module TypeChecker where

import Data.Functor.Identity (Identity (runIdentity))
import Control.Monad.Reader
import Control.Monad.Except
import qualified Data.Map

import AbsSyntax


data ConstVar = Const | Var
type FullType = (ConstVar, Type)

-- (standard env, return type)
type CheckEnv = (Data.Map.Map Ident FullType, Maybe Type)
type CheckError = String

emptyEnv :: CheckEnv
emptyEnv = (Data.Map.empty, Nothing)

-- Checker monad
type CM a = ReaderT CheckEnv (ExceptT CheckError Identity) a

runCM :: CM a -> CheckEnv -> Either CheckError a
runCM m env = runIdentity (runExceptT (runReaderT m env))

getType :: Ident -> CM (Maybe FullType)
getType id = do
  (env, _) <- ask
  let t = Data.Map.lookup id env
  return t

addToEnv :: Ident -> FullType -> CheckEnv -> CheckEnv
addToEnv id t (map, r) = (map', r)
  where
    map' = Data.Map.insert id t map

getReturn :: CM (Maybe Type)
getReturn = do
  (_, ret) <- ask
  return ret

setReturn :: Maybe Type -> CheckEnv -> CheckEnv
setReturn r (e, _) = (e, r)

typeFromFull :: FullType -> Type
typeFromFull (_, t) = t

showLine :: BNFC'Position -> String
showLine (Just (l, c)) = "line " ++ show l ++ ", clolumn " ++ show c
showLine Nothing = "No position"

showType :: Type -> String
showType (Int _) = "int"
showType (Bool _) = "bool"
showType (Str _) = "string"
showType Fun {} = "function (can't print details of function type)"

-- compare Types ---------------------------------------------------------------
compTypes :: Type -> Type -> Bool
compTypes (Int _) (Int _) = True
compTypes (Bool _) (Bool _) = True
compTypes (Str _) (Str _) = True
compTypes (Fun _ ret1 args1) (Fun _ ret2 args2) = compTypes ret1 ret2 && compArgsLists args1 args2
compTypes _ _ = False

compArgTypes :: ArgType -> ArgType -> Bool
compArgTypes (ValArg _ t1) (ValArg _ t2) = compTypes t1 t2
compArgTypes (RefArg _ t1) (RefArg _ t2) = compTypes t1 t2
compArgTypes _ _ = False

compArgsLists :: [ArgType] -> [ArgType] -> Bool
compArgsLists (h1:t1) (h2:t2) = compArgTypes h1 h2 && compArgsLists t1 t2
compArgsLists [] [] = True
compArgsLists _ _ = False

-- checkExpr -------------------------------------------------------------------
checkExpr :: Expr -> CM Type
checkExpr (ELitInt line _) = return (Int BNFC'NoPosition)

checkExpr (ELitTrue line) = return (Bool BNFC'NoPosition)

checkExpr (ELitFalse line) = return (Bool BNFC'NoPosition)

checkExpr (EString line _) = return (Str BNFC'NoPosition)

checkExpr (Neg line expr) = do
  t <- checkExpr expr
  case t of
    Int _ -> return (Int BNFC'NoPosition)
    _ -> throwError ("Integer negation of non-integer value at " ++ showLine line)

checkExpr (Not line expr) = do
  t <- checkExpr expr
  case t of
    Bool _ -> return (Int BNFC'NoPosition)
    _ -> throwError ("Bool negation of non-bool value at " ++ showLine line)

checkExpr (EMul line expr1 _ expr2) = do
  t1 <- checkExpr expr1
  t2 <- checkExpr expr2
  case (t1, t2) of
    (Int _, Int _) -> return (Int BNFC'NoPosition)
    _ -> throwError ("Mul type operation of non-integer values at " ++ showLine line)

checkExpr (EAdd line expr1 op expr2) = do
  t1 <- checkExpr expr1
  t2 <- checkExpr expr2
  case (t1, t2, op) of
    (Int _, Int _, _) -> return (Int BNFC'NoPosition)
    (Str _, Str _, Plus _) -> return (Str BNFC'NoPosition)
    _ -> throwError ("Add type operation of non-integer values at " ++ showLine line)

checkExpr (ERel line expr1 _ expr2) = do
  type1 <- checkExpr expr1
  type2 <- checkExpr expr2
  aux_check type1 type2
  where
    aux_check :: Type -> Type -> CM Type
    aux_check t1 t2
      | not (compTypes t1 t2) = throwError ("Comparison of different type values at " ++ showLine line)
      | compTypes t1 (Int BNFC'NoPosition) || compTypes t1 (Str BNFC'NoPosition) = return (Bool BNFC'NoPosition)
      | otherwise = throwError ("Type " ++ showType t1 ++ " is incomparable, at " ++ showLine line)

checkExpr (EAnd line expr1 expr2) = do
  t1 <- checkExpr expr1
  t2 <- checkExpr expr2
  case (t1, t2) of
    (Bool _, Bool _) -> return (Bool BNFC'NoPosition)
    _ -> throwError ("Logic operation of non-bool values at " ++ showLine line)

checkExpr (EOr line expr1 expr2) = do
  t1 <- checkExpr expr1
  t2 <- checkExpr expr2
  case (t1, t2) of
    (Bool _, Bool _) -> return (Bool BNFC'NoPosition)
    _ -> throwError ("Logic operation of non-bool values at " ++ showLine line)

checkExpr (EVar line x) = do
  maybe_t <- getType x
  case maybe_t of
    Just t -> return (typeFromFull t)
    Nothing -> throwError ("Variable " ++ show x ++ " not in scope at " ++ showLine line)

checkExpr (ECall line id args) = do
  full_type <- getType id
  (ret_type, args_types) <- funType full_type
  _ <- checkArgs args args_types
  return ret_type
  where
    funType :: Maybe FullType -> CM (Type, [ArgType])
    funType Nothing = throwError ("Function " ++ show id ++ " not in scope, at " ++ showLine line)
    funType (Just (_, Fun _ ret args)) = return (ret, args)
    funType _ = throwError (show id ++ " is not a function, at " ++ showLine line)

    checkArgs :: [Expr] -> [ArgType] -> CM ()
    checkArgs [] [] = return ()
    checkArgs [] _ = throwError ("Too many arguments for function " ++ show id ++ " at " ++ showLine line) 
    checkArgs _ [] = throwError ("Not enough arguments for function " ++ show id ++ " at " ++ showLine line)
    checkArgs (e:et) (t:tt) = checkArg e t >> checkArgs et tt

    checkArg :: Expr -> ArgType -> CM ()
    checkArg (EVar arg_line arg_id) (RefArg _ arg_t) = do
      var_t <- checkExpr (EVar arg_line arg_id)
      if compTypes arg_t var_t
        then return ()
        else throwError ("Mismatched argument type at " ++ showLine arg_line)
      checkConst arg_id
      where
        checkConst :: Ident -> CM ()
        checkConst id = do
          x <- getType id
          case x of
            Nothing -> undefined -- if expr is correct this is impossible
            Just (Const, _) -> throwError ("Cant assign const as reference argument, at " ++ showLine arg_line) 
            _ -> return () 
        
    checkArg expr (RefArg _ _) = throwError ("Argument of type reference must be a variable, at " ++ showLine (hasPosition expr))

    checkArg expr (ValArg _ arg_type) = do
      val_type <- checkExpr expr
      if compTypes val_type arg_type
        then return ()
        else throwError ("Mismatched argument type at " ++ showLine (hasPosition expr))

-- checkStmt -------------------------------------------------------------------
checkStmt :: Stmt -> CM (CheckEnv -> CheckEnv)
checkStmt (Empty _) = return id

checkStmt (Bre _) = return id

checkStmt (Cont _) = return id

checkStmt (Ret line expr) = do
  expr_t <- checkExpr expr
  ret_t <- getReturn
  case ret_t of
    Nothing -> throwError ("Return outside of function at " ++ showLine line)
    Just ret_t' -> if compTypes ret_t' expr_t then return () else throwError ("Wrong type of returned value at " ++ showLine line)
  return id

checkStmt (VarDecl line t var_id expr) = do
  expr_t <- checkExpr expr
  if compTypes t expr_t 
    then return (addToEnv var_id (Var, t))
    else throwError ("Assigned value doesn't match declared type at, " ++ showLine line)

checkStmt (ConstDecl line t var_id expr) = do
  expr_t <- checkExpr expr
  if compTypes t expr_t 
    then return (addToEnv var_id (Const, t))
    else throwError ("Assigned value doesn't match declared type at, " ++ showLine line)

checkStmt (Ass line var_id expr) = do
  var_t <- getType var_id
  var_t' <- case var_t of
    Nothing -> throwError ("Can't assign to not declared variable at, " ++ showLine line)
    Just (Const, _) -> throwError ("Can't assign to const at, " ++ showLine line)
    Just (Var, t) -> return t
  expr_t <- checkExpr expr
  if compTypes expr_t var_t'
    then return id
    else throwError ("Mismatched expression value in assign, at " ++ showLine line)

checkStmt (If line cond body) = do
  cond_t <- checkExpr cond
  if compTypes cond_t (Bool BNFC'NoPosition)
    then return ()
    else throwError ("Condition must be of type bool, at " ++ showLine line)
  checkStmt body
  return id

checkStmt (IfElse line cond body1 body2) = do
  cond_t <- checkExpr cond
  if compTypes cond_t (Bool BNFC'NoPosition)
    then return ()
    else throwError ("Condition must be of type bool, at " ++ showLine line)
  checkStmt body1
  checkStmt body2
  return id

checkStmt (While line cond body) = do
  cond_t <- checkExpr cond
  if compTypes cond_t (Bool BNFC'NoPosition)
    then return ()
    else throwError ("Condition must be of type bool, at " ++ showLine line)
  checkStmt body
  return id

checkStmt (For line var_id beg end body) = do
  beg_t <- checkExpr beg
  end_t <- checkExpr end
  checkInt beg_t
  checkInt end_t
  local (addToEnv var_id (Const, Int BNFC'NoPosition)) (checkStmt body)
  return id
    where
      checkInt :: Type -> CM ()
      checkInt (Int _) = return ()
      checkInt _ = throwError ("Beginning and end values in for must be of type int, at " ++ showLine line)

checkStmt (SExp _ expr) = do 
  checkExpr expr
  return id

checkStmt (Print line expr) = do
  expr_t <- checkExpr expr
  case expr_t of
    Fun {} -> throwError ("Can't print a function, at " ++ showLine line)
    _ -> return ()
  return id

checkStmt (FnDef line ret_t f_id args body) = do
  let args_t = map (\(Arg _ t _) -> t) args
  let fun_t = Fun BNFC'NoPosition ret_t args_t
  let args_f = foldr (\arg f -> add_arg arg . f) id args
  let add_fun = addToEnv f_id (Const, fun_t)
  let env_mod = args_f . setReturn (Just ret_t) . add_fun
  local env_mod (checkStmt body)
  return add_fun
    where
      add_arg :: Arg -> CheckEnv -> CheckEnv
      add_arg (Arg _ (ValArg _ arg_t) arg_id) = addToEnv arg_id (Var, arg_t)
      add_arg (Arg _ (RefArg _ arg_t) arg_id) = addToEnv arg_id (Var, arg_t)

checkStmt (BStmt line block) = do
  checkBlock block
  return id

checkBlock :: Block -> CM ()
checkBlock (Block _ []) = return ()
checkBlock (Block _ (h:t)) = do
  env_mod <- checkStmt h
  local env_mod (checkBlock (Block BNFC'NoPosition t)) 
  return ()

-- checkProg -------------------------------------------------------------------
checkProg :: Program -> CM ()
checkProg (Program line stmts) = checkBlock (Block line stmts)

typeCheckProgram :: Program -> Maybe CheckError
typeCheckProgram program = case monad_result of
  Left s -> Just s
  Right _ -> Nothing
  where
    monad_result = runCM (checkProg program) emptyEnv
