-- File generated by the BNF Converter (bnfc 2.9.4.1).

{-# LANGUAGE CPP #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE LambdaCase #-}
#if __GLASGOW_HASKELL__ <= 708
{-# LANGUAGE OverlappingInstances #-}
#endif

-- | Pretty-printer for PrintSyntax.

module PrintSyntax where

import Prelude
  ( ($), (.)
  , Bool(..), (==), (<)
  , Int, Integer, Double, (+), (-), (*)
  , String, (++)
  , ShowS, showChar, showString
  , all, elem, foldr, id, map, null, replicate, shows, span
  )
import Data.Char ( Char, isSpace )
import qualified AbsSyntax

-- | The top-level printing method.

printTree :: Print a => a -> String
printTree = render . prt 0

type Doc = [ShowS] -> [ShowS]

doc :: ShowS -> Doc
doc = (:)

render :: Doc -> String
render d = rend 0 False (map ($ "") $ d []) ""
  where
  rend
    :: Int        -- ^ Indentation level.
    -> Bool       -- ^ Pending indentation to be output before next character?
    -> [String]
    -> ShowS
  rend i p = \case
      "["      :ts -> char '[' . rend i False ts
      "("      :ts -> char '(' . rend i False ts
      "{"      :ts -> onNewLine i     p . showChar   '{'  . new (i+1) ts
      "}" : ";":ts -> onNewLine (i-1) p . showString "};" . new (i-1) ts
      "}"      :ts -> onNewLine (i-1) p . showChar   '}'  . new (i-1) ts
      [";"]        -> char ';'
      ";"      :ts -> char ';' . new i ts
      t  : ts@(s:_) | closingOrPunctuation s
                   -> pending . showString t . rend i False ts
      t        :ts -> pending . space t      . rend i False ts
      []           -> id
    where
    -- Output character after pending indentation.
    char :: Char -> ShowS
    char c = pending . showChar c

    -- Output pending indentation.
    pending :: ShowS
    pending = if p then indent i else id

  -- Indentation (spaces) for given indentation level.
  indent :: Int -> ShowS
  indent i = replicateS (2*i) (showChar ' ')

  -- Continue rendering in new line with new indentation.
  new :: Int -> [String] -> ShowS
  new j ts = showChar '\n' . rend j True ts

  -- Make sure we are on a fresh line.
  onNewLine :: Int -> Bool -> ShowS
  onNewLine i p = (if p then id else showChar '\n') . indent i

  -- Separate given string from following text by a space (if needed).
  space :: String -> ShowS
  space t s =
    case (all isSpace t', null spc, null rest) of
      (True , _   , True ) -> []              -- remove trailing space
      (False, _   , True ) -> t'              -- remove trailing space
      (False, True, False) -> t' ++ ' ' : s   -- add space if none
      _                    -> t' ++ s
    where
      t'          = showString t []
      (spc, rest) = span isSpace s

  closingOrPunctuation :: String -> Bool
  closingOrPunctuation [c] = c `elem` closerOrPunct
  closingOrPunctuation _   = False

  closerOrPunct :: String
  closerOrPunct = ")],;"

parenth :: Doc -> Doc
parenth ss = doc (showChar '(') . ss . doc (showChar ')')

concatS :: [ShowS] -> ShowS
concatS = foldr (.) id

concatD :: [Doc] -> Doc
concatD = foldr (.) id

replicateS :: Int -> ShowS -> ShowS
replicateS n f = concatS (replicate n f)

-- | The printer class does the job.

class Print a where
  prt :: Int -> a -> Doc

instance {-# OVERLAPPABLE #-} Print a => Print [a] where
  prt i = concatD . map (prt i)

instance Print Char where
  prt _ c = doc (showChar '\'' . mkEsc '\'' c . showChar '\'')

instance Print String where
  prt _ = printString

printString :: String -> Doc
printString s = doc (showChar '"' . concatS (map (mkEsc '"') s) . showChar '"')

mkEsc :: Char -> Char -> ShowS
mkEsc q = \case
  s | s == q -> showChar '\\' . showChar s
  '\\' -> showString "\\\\"
  '\n' -> showString "\\n"
  '\t' -> showString "\\t"
  s -> showChar s

prPrec :: Int -> Int -> Doc -> Doc
prPrec i j = if j < i then parenth else id

instance Print Integer where
  prt _ x = doc (shows x)

instance Print Double where
  prt _ x = doc (shows x)

instance Print AbsSyntax.Ident where
  prt _ (AbsSyntax.Ident i) = doc $ showString i
instance Print (AbsSyntax.Program' a) where
  prt i = \case
    AbsSyntax.Program _ stmts -> prPrec i 0 (concatD [prt 0 stmts])

instance Print [AbsSyntax.Stmt' a] where
  prt _ [] = concatD []
  prt _ (x:xs) = concatD [prt 0 x, prt 0 xs]

instance Print (AbsSyntax.Block' a) where
  prt i = \case
    AbsSyntax.Block _ stmts -> prPrec i 0 (concatD [doc (showString "{"), prt 0 stmts, doc (showString "}")])

instance Print (AbsSyntax.Stmt' a) where
  prt i = \case
    AbsSyntax.Empty _ -> prPrec i 0 (concatD [doc (showString ";")])
    AbsSyntax.BStmt _ block -> prPrec i 0 (concatD [prt 0 block])
    AbsSyntax.VarDecl _ type_ id_ expr -> prPrec i 0 (concatD [prt 0 type_, prt 0 id_, doc (showString "="), prt 0 expr, doc (showString ";")])
    AbsSyntax.ConstDecl _ type_ id_ expr -> prPrec i 0 (concatD [doc (showString "const"), prt 0 type_, prt 0 id_, doc (showString "="), prt 0 expr, doc (showString ";")])
    AbsSyntax.Ass _ id_ expr -> prPrec i 0 (concatD [prt 0 id_, doc (showString "="), prt 0 expr, doc (showString ";")])
    AbsSyntax.Ret _ expr -> prPrec i 0 (concatD [doc (showString "return"), prt 0 expr, doc (showString ";")])
    AbsSyntax.Bre _ -> prPrec i 0 (concatD [doc (showString "break"), doc (showString ";")])
    AbsSyntax.Cont _ -> prPrec i 0 (concatD [doc (showString "continue"), doc (showString ";")])
    AbsSyntax.If _ expr stmt -> prPrec i 0 (concatD [doc (showString "if"), doc (showString "("), prt 0 expr, doc (showString ")"), prt 0 stmt])
    AbsSyntax.IfElse _ expr stmt1 stmt2 -> prPrec i 0 (concatD [doc (showString "if"), doc (showString "("), prt 0 expr, doc (showString ")"), prt 0 stmt1, doc (showString "else"), prt 0 stmt2])
    AbsSyntax.While _ expr stmt -> prPrec i 0 (concatD [doc (showString "while"), doc (showString "("), prt 0 expr, doc (showString ")"), prt 0 stmt])
    AbsSyntax.For _ id_ expr1 expr2 stmt -> prPrec i 0 (concatD [doc (showString "for"), doc (showString "("), prt 0 id_, doc (showString "="), prt 0 expr1, doc (showString "to"), prt 0 expr2, doc (showString ")"), prt 0 stmt])
    AbsSyntax.SExp _ expr -> prPrec i 0 (concatD [prt 0 expr, doc (showString ";")])
    AbsSyntax.Print _ expr -> prPrec i 0 (concatD [doc (showString "print"), prt 0 expr, doc (showString ";")])
    AbsSyntax.FnDef _ type_ id_ args stmt -> prPrec i 0 (concatD [prt 0 type_, prt 0 id_, doc (showString "("), prt 0 args, doc (showString ")"), prt 0 stmt])

instance Print (AbsSyntax.ArgType' a) where
  prt i = \case
    AbsSyntax.ValArg _ type_ -> prPrec i 0 (concatD [prt 0 type_])
    AbsSyntax.RefArg _ type_ -> prPrec i 0 (concatD [prt 0 type_, doc (showString "&")])

instance Print [AbsSyntax.ArgType' a] where
  prt _ [] = concatD []
  prt _ [x] = concatD [prt 0 x]
  prt _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]

instance Print (AbsSyntax.Arg' a) where
  prt i = \case
    AbsSyntax.Arg _ argtype id_ -> prPrec i 0 (concatD [prt 0 argtype, prt 0 id_])

instance Print [AbsSyntax.Arg' a] where
  prt _ [] = concatD []
  prt _ [x] = concatD [prt 0 x]
  prt _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]

instance Print (AbsSyntax.Type' a) where
  prt i = \case
    AbsSyntax.Int _ -> prPrec i 0 (concatD [doc (showString "int")])
    AbsSyntax.Str _ -> prPrec i 0 (concatD [doc (showString "string")])
    AbsSyntax.Bool _ -> prPrec i 0 (concatD [doc (showString "bool")])
    AbsSyntax.Fun _ type_ argtypes -> prPrec i 0 (concatD [prt 0 type_, doc (showString "("), prt 0 argtypes, doc (showString ")")])

instance Print [AbsSyntax.Type' a] where
  prt _ [] = concatD []
  prt _ [x] = concatD [prt 0 x]
  prt _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]

instance Print (AbsSyntax.Expr' a) where
  prt i = \case
    AbsSyntax.EVar _ id_ -> prPrec i 6 (concatD [prt 0 id_])
    AbsSyntax.ELitInt _ n -> prPrec i 6 (concatD [prt 0 n])
    AbsSyntax.ELitTrue _ -> prPrec i 6 (concatD [doc (showString "true")])
    AbsSyntax.ELitFalse _ -> prPrec i 6 (concatD [doc (showString "false")])
    AbsSyntax.ECall _ id_ exprs -> prPrec i 6 (concatD [prt 0 id_, doc (showString "("), prt 0 exprs, doc (showString ")")])
    AbsSyntax.EString _ str -> prPrec i 6 (concatD [printString str])
    AbsSyntax.Neg _ expr -> prPrec i 5 (concatD [doc (showString "-"), prt 6 expr])
    AbsSyntax.Not _ expr -> prPrec i 5 (concatD [doc (showString "!"), prt 6 expr])
    AbsSyntax.EMul _ expr1 mulop expr2 -> prPrec i 4 (concatD [prt 4 expr1, prt 0 mulop, prt 5 expr2])
    AbsSyntax.EAdd _ expr1 addop expr2 -> prPrec i 3 (concatD [prt 3 expr1, prt 0 addop, prt 4 expr2])
    AbsSyntax.ERel _ expr1 relop expr2 -> prPrec i 2 (concatD [prt 2 expr1, prt 0 relop, prt 3 expr2])
    AbsSyntax.EAnd _ expr1 expr2 -> prPrec i 1 (concatD [prt 2 expr1, doc (showString "&&"), prt 1 expr2])
    AbsSyntax.EOr _ expr1 expr2 -> prPrec i 0 (concatD [prt 1 expr1, doc (showString "||"), prt 0 expr2])

instance Print [AbsSyntax.Expr' a] where
  prt _ [] = concatD []
  prt _ [x] = concatD [prt 0 x]
  prt _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]

instance Print (AbsSyntax.AddOp' a) where
  prt i = \case
    AbsSyntax.Plus _ -> prPrec i 0 (concatD [doc (showString "+")])
    AbsSyntax.Minus _ -> prPrec i 0 (concatD [doc (showString "-")])

instance Print (AbsSyntax.MulOp' a) where
  prt i = \case
    AbsSyntax.Times _ -> prPrec i 0 (concatD [doc (showString "*")])
    AbsSyntax.Div _ -> prPrec i 0 (concatD [doc (showString "/")])
    AbsSyntax.Mod _ -> prPrec i 0 (concatD [doc (showString "%")])

instance Print (AbsSyntax.RelOp' a) where
  prt i = \case
    AbsSyntax.LTH _ -> prPrec i 0 (concatD [doc (showString "<")])
    AbsSyntax.LE _ -> prPrec i 0 (concatD [doc (showString "<=")])
    AbsSyntax.GTH _ -> prPrec i 0 (concatD [doc (showString ">")])
    AbsSyntax.GE _ -> prPrec i 0 (concatD [doc (showString ">=")])
    AbsSyntax.EQU _ -> prPrec i 0 (concatD [doc (showString "==")])
    AbsSyntax.NE _ -> prPrec i 0 (concatD [doc (showString "!=")])
