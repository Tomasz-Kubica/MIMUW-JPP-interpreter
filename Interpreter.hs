{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Interpreter where

import Data.Functor.Identity (Identity (runIdentity))
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Writer
import Control.Monad.Except
import qualified Data.Map

import AbsSyntax


data Value = VInt Integer | VBool Bool | VStr String | VFun IntEnv [Arg] (IM Value)

data IntException = UserError String | EReturn Value | EBreak | EContinue

type Loc = Int

type IntEnv = Data.Map.Map Ident Loc

type IntStore = Data.Map.Map Loc Value

type Output = [String]

emptyEnv :: IntEnv
emptyEnv = Data.Map.empty

emptyStore :: IntStore
emptyStore = Data.Map.empty

type IM a = ExceptT IntException (WriterT Output (ReaderT IntEnv (StateT IntStore Identity))) a

runIM :: IM a -> IntEnv -> IntStore -> (Either IntException a, Output)
runIM monad env store = (res, out)
  where
    ((res, out), _) = runIdentity (runStateT (runReaderT (runWriterT (runExceptT monad)) env) store)

--- Pretty shows ---------------------------------------------------------------

showLine :: BNFC'Position -> String
showLine (Just (l, c)) = "line " ++ show l ++ ", clolumn " ++ show c
showLine Nothing = "No position"

showE :: IntException -> String
showE (UserError s) = s

showOut :: Output -> String
showOut (h:t) = h ++ "\n" ++ showOut t

showOut [] = ""

--- Access Env and Store -------------------------------------------------------

getLoc :: Ident -> IM Loc
getLoc id = do
  env <- ask
  maybe (throwError (UserError ("loc" ++ show id))) return (Data.Map.lookup id env)

setLoc :: Ident -> Loc -> IntEnv -> IntEnv
setLoc = Data.Map.insert

getValue :: Loc -> IM Value
getValue l = do
  store <- get
  maybe undefined return (Data.Map.lookup l store)

setValue :: Loc -> Value -> IM ()
setValue l v = do
  store <- get
  put (Data.Map.insert l v store)

getVar :: Ident -> IM Value
getVar id = do
  l <- getLoc id
  getValue l

setVar :: Ident -> Value -> IM ()
setVar id v = do
  l <- getLoc id
  setValue l v

newLoc :: IM Loc
newLoc = do
  store <- get
  let keys = Data.Map.keys store
  let max_key = foldr max 0 keys
  return (max_key + 1)


--- Operators ------------------------------------------------------------------

addOpEval :: AddOp -> Value -> Value -> IM Value
addOpEval (Plus _) (VInt a) (VInt b) = return (VInt (a + b))

addOpEval (Plus _) (VStr a) (VStr b) = return (VStr (a ++ b))

addOpEval (Minus _) (VInt a) (VInt b) = return (VInt (a - b))

mulOpEval :: MulOp -> Value -> Value -> IM Value
mulOpEval (Times _) (VInt a) (VInt b) = return (VInt (a * b))

mulOpEval (Div line) (VInt a) (VInt 0) = throwError (UserError ("Division by zero at " ++ showLine line))

mulOpEval (Div _) (VInt a) (VInt b) = return (VInt (div a  b))

mulOpEval (Mod line) (VInt a) (VInt 0) = throwError (UserError ("Modulo by zero at " ++ showLine line))

mulOpEval (Mod _) (VInt a) (VInt b) = return (VInt (mod a b))

relOpFun :: Ord a => RelOp -> a -> a -> Bool
relOpFun (LTH _) = (<)
relOpFun (LE _) = (<=)
relOpFun (GTH _) = (>)
relOpFun (GE _) = (>=)
relOpFun (EQU _) = (==)
relOpFun (NE _) = (/=)

relOpEval :: RelOp -> Value -> Value -> IM Value
relOpEval op (VInt a) (VInt b) = return (VBool (f a b))
  where
    f = relOpFun op

relOpEval op (VStr a) (VStr b) = return (VBool (f a b))
  where
    f = relOpFun op


--- Show Val -------------------------------------------------------------------

myShowVal :: Value -> String
myShowVal (VInt x) = show x

myShowVal (VStr s) = show s

myShowVal (VBool True) = "True"

myShowVal (VBool False) = "False"


--- Eval Expr ------------------------------------------------------------------

evalExpr :: Expr -> IM Value
evalExpr (EVar _ id) = getVar id

evalExpr (ELitInt _ x) = return (VInt x)

evalExpr (ELitTrue _) = return (VBool True)

evalExpr (ELitFalse _) = return (VBool False)

evalExpr (EString _ s) = return (VStr s)

evalExpr (Neg _ expr) = do
  ev <- evalExpr expr
  case ev of
    VInt n -> return (VInt (-n))
    _ -> undefined

evalExpr (EAdd _ e1 op e2) = do
  v1 <- evalExpr e1
  v2 <- evalExpr e2
  addOpEval op v1 v2

evalExpr (EMul _ e1 op e2) = do
  v1 <- evalExpr e1
  v2 <- evalExpr e2
  mulOpEval op v1 v2

evalExpr (ERel _ e1 op e2) = do
  v1 <- evalExpr e1
  v2 <- evalExpr e2
  relOpEval op v1 v2

evalExpr (EAnd _ e1 e2) = do
  v1 <- evalExpr e1
  v2 <- evalExpr e2
  case (v1, v2) of
    (VBool b1, VBool b2) -> return (VBool (b1 && b2))
    _ -> undefined

evalExpr (EOr _ e1 e2) = do
  v1 <- evalExpr e1
  v2 <- evalExpr e2
  case (v1, v2) of
    (VBool b1, VBool b2) -> return (VBool (b1 || b2))
    _ -> undefined

evalExpr (Not _ e) = do
  v <- evalExpr e
  case v of
    VBool b -> return (VBool (not b))
    _ -> undefined

evalExpr (ECall _ id args) = do
  fun <- getVar id
  case fun of
    VFun f_env f_args f_body -> do
      insert_args <- insertArgs f_args args
      let f_body' = local (const (insert_args f_env)) f_body
      local insert_args f_body'
    _ -> undefined

insertArgs :: [Arg] -> [Expr] -> IM (IntEnv -> IntEnv)
insertArgs [] [] = return id

insertArgs ((Arg _ (ValArg _ _) id):at) (expr:et) = do
  v <- evalExpr expr
  l <- newLoc
  setValue l v
  let insert_arg = setLoc id l
  insert_rest <- insertArgs at et
  return (insert_rest . insert_arg)

insertArgs ((Arg _ (RefArg _ _) a_id):at) ((EVar _ e_id):et) = do
  l <- getLoc e_id
  let insert_arg = setLoc a_id l
  insert_rest <- insertArgs at et
  return (insert_rest . insert_arg)


--- Eval Stmt ------------------------------------------------------------------

evalStmt :: Stmt -> IM (IntEnv -> IntEnv)
evalStmt (Empty _) = return id

evalStmt (BStmt _ (Block _ stmts)) = do
  evalStmtArr stmts
  return id

evalStmt (VarDecl _ _ id expr) = do
  v <- evalExpr expr
  l <- newLoc
  setValue l v
  return (setLoc id l)

-- Const constraints are checked by TypeChecker
evalStmt (ConstDecl l t id expr) = evalStmt (VarDecl l t id expr)

evalStmt (Ass _ vid expr) = do
  v <- evalExpr expr
  l <- getLoc vid
  setValue l v
  return id

evalStmt (Ret _ expr) = do
  v <- evalExpr expr
  throwError (EReturn v)

evalStmt (Bre _) = do
  throwError EBreak

evalStmt (Cont _) = do
  throwError EContinue

evalStmt (If _ cond stmt) = do
  v_cond <- evalExpr cond
  case v_cond of
    VBool b -> if b then evalStmt stmt else return id
    _ -> undefined

evalStmt (IfElse _ cond stmt_t stmt_f) = do
  v_cond <- evalExpr cond
  case v_cond of
    VBool b -> evalStmt (if b then stmt_t else stmt_f)
    _ -> undefined

evalStmt (SExp _ expr) = do
  evalExpr expr
  return id

evalStmt (Print _ expr) = do
  v <- evalExpr expr
  let s = myShowVal v
  tell [s]
  return id

evalStmt (FnDef line _ f_id args body) = do
  l <- newLoc
  let body_m = evalStmt body
  let body_m' = body_m >> throwError (UserError ("Function ended without return, defined at " ++ showLine line))
  let body_m'' = catchError body_m' catch_error
  env <- ask
  let insert_fun = setLoc f_id l
  let fun_env = insert_fun env
  let fun = VFun fun_env args body_m''
  setValue l fun
  return insert_fun
    where
      catch_error :: IntException -> IM Value
      catch_error (EReturn v) = return v
      catch_error EBreak = throwError (UserError ("Break outside of loop in function defined at " ++ showLine line))
      catch_error EContinue = throwError (UserError ("Continue outside of loop in function defined at " ++ showLine line))
      catch_error e = throwError e

evalStmt (While line cond body) = do
  cond_v <- evalExpr cond
  let body_m = evalStmt body
  case cond_v of
    VBool b -> if b
      then body_m >> evalStmt (While line cond body)
      else return id
    _ -> undefined
  return id

evalStmt (For _ v_id start end body) = do
  v_start <- evalExpr start
  v_end <- evalExpr end
  let values = for_values v_start v_end
  let bodies_monad = foldr (\v m -> val_to_monad v >> m) (return ()) values
  catchError bodies_monad catch_brk
  return id
    where
      for_values :: Value -> Value -> [Value]
      for_values (VInt s) (VInt e)
        | s <= e = VInt s:for_values (VInt (s + 1)) (VInt e)
        | otherwise = []

      body_monad = evalStmt body >> return ()
      body_monad' = catchError body_monad catch_cont

      catch_cont :: IntException -> IM ()
      catch_cont EContinue = return ()
      catch_cont e = throwError e

      catch_brk :: IntException -> IM ()
      catch_brk EBreak = return ()
      catch_brk e = throwError e

      val_to_monad :: Value -> IM ()
      val_to_monad v = do
        l <- newLoc
        setValue l v
        local (setLoc v_id l) body_monad'


--- Eval Program ---------------------------------------------------------------

evalProg :: Program -> IM ()
evalProg (Program _ stmts) = evalStmtArr stmts

interpretProgram :: Program -> (Maybe IntException, Output)
interpretProgram prg = (r_except, out)
  where
   (except, out) = runIM (evalProg prg) emptyEnv emptyStore
   r_except = case except of
     Left e -> Just e
     Right _ -> Nothing

evalStmtArr :: [Stmt] -> IM ()
evalStmtArr [] = return ()

evalStmtArr (stmt:t) = do
  f <- evalStmt stmt
  local f (evalStmtArr t)
