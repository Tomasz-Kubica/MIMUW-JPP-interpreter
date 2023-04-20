{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Interpreter where

import Data.Functor.Identity (Identity (runIdentity))
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Writer
import Control.Monad.Except
import qualified Data.Map

import AbsSyntax
import Llvm (LlvmStatement(Return))


data Value = VInt Integer | VBool Bool | VStr String | VFun IntEnv [Arg] (IM Value)

data IntException = UserError String | Return Value | Break | Continue

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

--- Access Env and Store -------------------------------------------------------

getLoc :: Ident -> IM Loc
getLoc id = do
  env <- ask
  maybe undefined return (Data.Map.lookup id env)

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

mulOpEval (Div line) (VInt a) (VInt 0) = throwError (UserError ("Division by zero at " ++ show line))

mulOpEval (Div _) (VInt a) (VInt b) = return (VInt (div a  b))

mulOpEval (Mod line) (VInt a) (VInt 0) = throwError (UserError ("Modulo by zero at " ++ show line))

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

evalExpr (ECall _ id args) = do
  fun <- getVar id
  case fun of
    VFun f_env f_args f_body -> do
      insert_args <- insertArgs f_args args
      local insert_args f_body
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

