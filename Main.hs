module Main where

import ParSyntax
import AbsSyntax

import TypeChecker(typeCheckProgram)
import Interpreter(interpretProgram, showE, showOut)

import qualified Data.Maybe

main = do
  interact check
  putStrLn ""

check s = case program of
  Left parser_err -> parser_err
  Right program -> Data.Maybe.fromMaybe (inter program) (typeCheckProgram program)
  where
    tokens = myLexer s
    program = pProgram tokens

inter :: Program -> String
inter program = showOut out ++ maybe "" showE except
  where
    (except, out) = interpretProgram program
