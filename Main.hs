module Main where

import ParSyntax
import AbsSyntax

import TypeChecker(typeCheckProgram)
import Interpreter(interpretProgram, showE, showOut)
import System.Environment ( getArgs )

import qualified Data.Maybe

check :: [Char] -> String
check s = case program of
  Left parser_err -> parser_err
  Right program -> Data.Maybe.fromMaybe (inter program) (typeCheckProgram program)
  where
    tokens = myLexer s
    program = pProgram tokens

checkM :: [Char] -> IO ()
checkM s = putStrLn (check s)

checkFile :: FilePath -> IO ()
checkFile f = readFile f >>= checkM

inter :: Program -> String
inter program = showOut out ++ maybe "" showE except
  where
    (except, out) = interpretProgram program

usage :: IO ()
usage = do
  putStrLn $ unlines
    [ "usage: Call with one of the following argument combinations:"
    , "  --help          Display this help message."
    , "  (no arguments)  Parse stdin verbosely."
    , "  (files)         Parse content of files verbosely."
    ]

main :: IO ()
main = do
  args <- getArgs
  case args of
    ["--help"] -> usage
    []         -> getContents >>= checkM
    fs         -> mapM_ checkFile fs

