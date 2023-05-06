module Main where

import ParSyntax
import AbsSyntax

import TypeChecker(typeCheckProgram)
import Interpreter(interpretProgram, showE, showOut)
import System.Environment ( getArgs )
import System.IO (hPutStrLn, stderr)

import qualified Data.Maybe

check :: [Char] -> IO ()
check s = case program of
  Left parser_err -> hPutStrLn stderr parser_err
  Right program -> typeCheckM program >>= inter program
  where
    tokens = myLexer s
    program = pProgram tokens

typeCheckM :: Program -> IO Bool
typeCheckM p = do
  let res = typeCheckProgram p
  case res of
    Nothing -> return True
    Just err -> hPutStrLn stderr err >> return False

checkFile :: FilePath -> IO ()
checkFile f = readFile f >>= check

inter :: Program -> Bool -> IO ()
inter program True = do
  putStr (showOut out)
  hPutStrLn stderr err_to_print
  where
    (except, out) = interpretProgram program
    err_to_print = maybe "" showE except

inter _ False = return ()

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
    []         -> getContents >>= check
    fs         -> mapM_ checkFile fs

