module Main where

import ParSyntax
import AbsSyntax

import TypeChecker(typeCheckProgram)

main = do
  interact check
  putStrLn ""

check s = case program of
  Left parser_err -> parser_err
  Right program -> show (typeCheckProgram program)
  where
    tokens = myLexer s
    program = pProgram tokens

