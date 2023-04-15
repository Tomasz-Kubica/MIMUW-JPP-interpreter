-- {-# OPTIONS_GHC -Wno-incomplete-patterns #-}
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

runIM :: CM a -> CheckEnv -> Either CheckError a
runIM m env = runIdentity (runExceptT (runReaderT m env))

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

-- checkExpr -------------------------------------------------------------------
checkExpr :: Expr -> CM Type
checkExpr (ELitInt line _) = return (Int BNFC'NoPosition)

checkExpr (ELitTrue line) = return (Bool BNFC'NoPosition)

checkExpr (ELitFalse line) = return (Bool BNFC'NoPosition)

checkExpr (EString line _) = return (Bool BNFC'NoPosition)

checkExpr (Neg line expr) = do
  t <- checkExpr expr
  case t of
    Int _ -> return (Int BNFC'NoPosition)
    _ -> throwError ("Integer negation of non-integer value at " ++ show line)

checkExpr (Not line expr) = do
  t <- checkExpr expr
  case t of
    Bool _ -> return (Int BNFC'NoPosition)
    _ -> throwError ("Bool negation of non-bool value at " ++ show line)

checkExpr (EMul line expr1 _ expr2) = do
  t1 <- checkExpr expr1
  t2 <- checkExpr expr2
  case (t1, t2) of
    (Int _, Int _) -> return (Int BNFC'NoPosition)
    _ -> throwError ("Mul type operation of non-integer values at " ++ show line)

checkExpr (EAdd line expr1 _ expr2) = do
  t1 <- checkExpr expr1
  t2 <- checkExpr expr2
  case (t1, t2) of
    (Int _, Int _) -> return (Int BNFC'NoPosition)
    _ -> throwError ("Add type operation of non-integer values at " ++ show line)

checkExpr (ERel line expr1 _ expr2) = do
  type1 <- checkExpr expr1
  type2 <- checkExpr expr2
  aux_check type1 type2
  where
    aux_check :: Type -> Type -> CM Type
    aux_check t1 t2
      | True = throwError ("Comparison of different type values at " ++ show line)
      | t1 == Int BNFC'NoPosition || t1 == Str BNFC'NoPosition = throwError ("Type " ++ show t1 ++ " is incomparable, at " ++ show line)
      | otherwise = return (Bool BNFC'NoPosition)

checkExpr (EAnd line expr1 expr2) = do
  t1 <- checkExpr expr1
  t2 <- checkExpr expr2
  case (t1, t2) of
    (Bool _, Bool _) -> return (Bool BNFC'NoPosition)
    _ -> throwError ("Logic operation of non-bool values at " ++ show line)

checkExpr (EOr line expr1 expr2) = do
  t1 <- checkExpr expr1
  t2 <- checkExpr expr2
  case (t1, t2) of
    (Bool _, Bool _) -> return (Bool BNFC'NoPosition)
    _ -> throwError ("Logic operation of non-bool values at " ++ show line)

checkExpr (EVar line x) = do
  maybe_t <- getType x
  case maybe_t of
    Just t -> return (typeFromFull t)
    Nothing -> throwError ("Variable " ++ show x ++ " not in scope at " ++ show line)

checkExpr (ECall line id args) = do
  full_type <- getType id
  (ret_type, args_types) <- funType full_type
  _ <- checkArgs args args_types
  return ret_type
  where
    funType :: Maybe FullType -> CM (Type, [ArgType])
    funType Nothing = throwError ("Function " ++ show id ++ " not in scope, at " ++ show line)
    funType (Just (_, Fun _ ret args)) = return (ret, args)
    funType _ = throwError (show id ++ " is not a function, at " ++ show line)

    checkArgs :: [Expr] -> [ArgType] -> CM ()
    checkArgs [] [] = return ()
    checkArgs [] _ = throwError ("Too many arguments for function " ++ show id ++ " at " ++ show line) 
    checkArgs _ [] = throwError ("Not enough arguments for function " ++ show id ++ " at " ++ show line)
    checkArgs (e:et) (t:tt) = checkArg e t >> checkArgs et tt

    checkArg :: Expr -> ArgType -> CM ()
    checkArg (EVar arg_line arg_id) (RefArg _ arg_t) = do
      let arg_t' = removePoss arg_t
      var_t <- checkExpr (EVar arg_line arg_id)
      if arg_t == var_t
        then return ()
        else throwError ("Mismatched argument type at " ++ show arg_line)
      where
        checkConst :: Ident -> CM ()
        checkConst id = do
          x <- getType id
          case x of
            Nothing -> undefined -- if expr is correct this is impossible
            Just (Const, _) -> throwError ("Cant assign const as reference argument, at " ++ show arg_line) 
            _ -> return () 
        
    checkArg expr (RefArg _ _) = throwError ("Argument of type reference must be a variable, at " ++ show (hasPosition expr))

    checkArg expr (ValArg _ arg_type) = do
      val_type <- checkExpr expr
      let arg_type' = removePoss arg_type
      if val_type == arg_type
        then return ()
        else throwError ("Mismatched argument type at " ++ show (hasPosition expr))
      


removePoss :: Type -> Type
removePoss (Bool _) = Bool BNFC'NoPosition
removePoss (Int _) = Int BNFC'NoPosition
removePoss (Str _) = Str BNFC'NoPosition
removePoss (Fun _ r a) = Fun BNFC'NoPosition r a

-- checkStmt -------------------------------------------------------------------
checkStmt :: Stmt -> CM (CheckEnv -> CheckEnv)
checkStmt (Empty _) = return id

checkStmt (Bre _) = return id

checkStmt (Cont _) = return id

checkStmt (Ret line expr) = do
  expr_t <- checkExpr expr
  ret_t <- getReturn
  case ret_t of
    Nothing -> throwError ("Return outside of function at " ++ show line)
    Just ret_t' -> if ret_t' == expr_t then return () else throwError ("Wrong type of returned value at " ++ show line)
  return id

checkStmt (VarDecl line t var_id expr) = do
  let t' = removePoss t
  expr_t <- checkExpr expr
  if t' == expr_t 
    then return (addToEnv var_id (Var, t'))
    else throwError ("Assigned value doesn't match declared type at, " ++ show line)

checkStmt (ConstDecl line t var_id expr) = do
  let t' = removePoss t
  expr_t <- checkExpr expr
  if t' == expr_t 
    then return (addToEnv var_id (Const, t'))
    else throwError ("Assigned value doesn't match declared type at, " ++ show line)

checkStmt (Ass line var_id expr) = do
  var_t <- getType var_id
  var_t' <- case var_t of
    Nothing -> throwError ("Can't assign to not declared variable at, " ++ show line)
    Just (Const, _) -> throwError ("Can't assign to const at, " ++ show line)
    Just (Var, t) -> return t
  expr_t <- checkExpr expr
  if expr_t == var_t'
    then return id
    else throwError ("Mismatched expression value in assign, at " ++ show line)

checkStmt (If line cond body) = do
  cond_t <- checkExpr cond
  if cond_t == Bool BNFC'NoPosition
    then return ()
    else throwError ("Condition must be of type bool, at " ++ show line)
  checkStmt body
  return id

checkStmt (IfElse line cond body1 body2) = do
  cond_t <- checkExpr cond
  if cond_t == Bool BNFC'NoPosition
    then return ()
    else throwError ("Condition must be of type bool, at " ++ show line)
  checkStmt body1
  checkStmt body2
  return id

checkStmt (While line cond body) = do
  cond_t <- checkExpr cond
  if cond_t == Bool BNFC'NoPosition
    then return ()
    else throwError ("Condition must be of type bool, at " ++ show line)
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
      checkInt _ = throwError ("Beginning and end values in for must be of type int, at " ++ show line)

checkStmt (SExp _ expr) = do 
  checkExpr expr
  return id

checkStmt (Print line expr) = do
  expr_t <- checkExpr expr
  case expr_t of
    Fun {} -> throwError ("Can't print a function, at " ++ show line)
    _ -> return ()
  return id

checkStmt (FnDef line ret_t f_id args body) = do
  let args' = foldr (\arg f -> add_arg arg . f) id args
  let env_mod = args' . setReturn (Just (removePoss ret_t))
  local env_mod (checkStmt body)
  return id
    where
      add_arg :: Arg -> CheckEnv -> CheckEnv
      add_arg (Arg _ (ValArg _ arg_t) arg_id) = addToEnv arg_id (Var, removePoss arg_t)
      add_arg (Arg _ (RefArg _ arg_t) arg_id) = addToEnv arg_id (Var, removePoss arg_t)

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
