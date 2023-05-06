{-# OPTIONS_GHC -w #-}
{-# OPTIONS -XMagicHash -XBangPatterns -XTypeSynonymInstances -XFlexibleInstances -cpp #-}
#if __GLASGOW_HASKELL__ >= 710
{-# OPTIONS_GHC -XPartialTypeSignatures #-}
#endif
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
{-# LANGUAGE PatternSynonyms #-}

module ParSyntax
  ( happyError
  , myLexer
  , pProgram
  , pListStmt
  , pBlock
  , pStmt
  , pArgType
  , pListArgType
  , pArg
  , pListArg
  , pType
  , pListType
  , pExpr6
  , pExpr5
  , pExpr4
  , pExpr3
  , pExpr2
  , pExpr1
  , pExpr
  , pListExpr
  , pAddOp
  , pMulOp
  , pRelOp
  ) where

import Prelude

import qualified AbsSyntax
import LexSyntax
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import qualified GHC.Exts as Happy_GHC_Exts
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.1.1

newtype HappyAbsSyn  = HappyAbsSyn HappyAny
#if __GLASGOW_HASKELL__ >= 607
type HappyAny = Happy_GHC_Exts.Any
#else
type HappyAny = forall a . a
#endif
newtype HappyWrap24 = HappyWrap24 ((AbsSyntax.BNFC'Position, AbsSyntax.Ident))
happyIn24 :: ((AbsSyntax.BNFC'Position, AbsSyntax.Ident)) -> (HappyAbsSyn )
happyIn24 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap24 x)
{-# INLINE happyIn24 #-}
happyOut24 :: (HappyAbsSyn ) -> HappyWrap24
happyOut24 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut24 #-}
newtype HappyWrap25 = HappyWrap25 ((AbsSyntax.BNFC'Position, Integer))
happyIn25 :: ((AbsSyntax.BNFC'Position, Integer)) -> (HappyAbsSyn )
happyIn25 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap25 x)
{-# INLINE happyIn25 #-}
happyOut25 :: (HappyAbsSyn ) -> HappyWrap25
happyOut25 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut25 #-}
newtype HappyWrap26 = HappyWrap26 ((AbsSyntax.BNFC'Position, String))
happyIn26 :: ((AbsSyntax.BNFC'Position, String)) -> (HappyAbsSyn )
happyIn26 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap26 x)
{-# INLINE happyIn26 #-}
happyOut26 :: (HappyAbsSyn ) -> HappyWrap26
happyOut26 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut26 #-}
newtype HappyWrap27 = HappyWrap27 ((AbsSyntax.BNFC'Position, AbsSyntax.Program))
happyIn27 :: ((AbsSyntax.BNFC'Position, AbsSyntax.Program)) -> (HappyAbsSyn )
happyIn27 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap27 x)
{-# INLINE happyIn27 #-}
happyOut27 :: (HappyAbsSyn ) -> HappyWrap27
happyOut27 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut27 #-}
newtype HappyWrap28 = HappyWrap28 ((AbsSyntax.BNFC'Position, [AbsSyntax.Stmt]))
happyIn28 :: ((AbsSyntax.BNFC'Position, [AbsSyntax.Stmt])) -> (HappyAbsSyn )
happyIn28 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap28 x)
{-# INLINE happyIn28 #-}
happyOut28 :: (HappyAbsSyn ) -> HappyWrap28
happyOut28 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut28 #-}
newtype HappyWrap29 = HappyWrap29 ((AbsSyntax.BNFC'Position, AbsSyntax.Block))
happyIn29 :: ((AbsSyntax.BNFC'Position, AbsSyntax.Block)) -> (HappyAbsSyn )
happyIn29 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap29 x)
{-# INLINE happyIn29 #-}
happyOut29 :: (HappyAbsSyn ) -> HappyWrap29
happyOut29 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut29 #-}
newtype HappyWrap30 = HappyWrap30 ((AbsSyntax.BNFC'Position, AbsSyntax.Stmt))
happyIn30 :: ((AbsSyntax.BNFC'Position, AbsSyntax.Stmt)) -> (HappyAbsSyn )
happyIn30 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap30 x)
{-# INLINE happyIn30 #-}
happyOut30 :: (HappyAbsSyn ) -> HappyWrap30
happyOut30 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut30 #-}
newtype HappyWrap31 = HappyWrap31 ((AbsSyntax.BNFC'Position, AbsSyntax.ArgType))
happyIn31 :: ((AbsSyntax.BNFC'Position, AbsSyntax.ArgType)) -> (HappyAbsSyn )
happyIn31 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap31 x)
{-# INLINE happyIn31 #-}
happyOut31 :: (HappyAbsSyn ) -> HappyWrap31
happyOut31 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut31 #-}
newtype HappyWrap32 = HappyWrap32 ((AbsSyntax.BNFC'Position, [AbsSyntax.ArgType]))
happyIn32 :: ((AbsSyntax.BNFC'Position, [AbsSyntax.ArgType])) -> (HappyAbsSyn )
happyIn32 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap32 x)
{-# INLINE happyIn32 #-}
happyOut32 :: (HappyAbsSyn ) -> HappyWrap32
happyOut32 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut32 #-}
newtype HappyWrap33 = HappyWrap33 ((AbsSyntax.BNFC'Position, AbsSyntax.Arg))
happyIn33 :: ((AbsSyntax.BNFC'Position, AbsSyntax.Arg)) -> (HappyAbsSyn )
happyIn33 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap33 x)
{-# INLINE happyIn33 #-}
happyOut33 :: (HappyAbsSyn ) -> HappyWrap33
happyOut33 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut33 #-}
newtype HappyWrap34 = HappyWrap34 ((AbsSyntax.BNFC'Position, [AbsSyntax.Arg]))
happyIn34 :: ((AbsSyntax.BNFC'Position, [AbsSyntax.Arg])) -> (HappyAbsSyn )
happyIn34 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap34 x)
{-# INLINE happyIn34 #-}
happyOut34 :: (HappyAbsSyn ) -> HappyWrap34
happyOut34 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut34 #-}
newtype HappyWrap35 = HappyWrap35 ((AbsSyntax.BNFC'Position, AbsSyntax.Type))
happyIn35 :: ((AbsSyntax.BNFC'Position, AbsSyntax.Type)) -> (HappyAbsSyn )
happyIn35 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap35 x)
{-# INLINE happyIn35 #-}
happyOut35 :: (HappyAbsSyn ) -> HappyWrap35
happyOut35 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut35 #-}
newtype HappyWrap36 = HappyWrap36 ((AbsSyntax.BNFC'Position, [AbsSyntax.Type]))
happyIn36 :: ((AbsSyntax.BNFC'Position, [AbsSyntax.Type])) -> (HappyAbsSyn )
happyIn36 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap36 x)
{-# INLINE happyIn36 #-}
happyOut36 :: (HappyAbsSyn ) -> HappyWrap36
happyOut36 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut36 #-}
newtype HappyWrap37 = HappyWrap37 ((AbsSyntax.BNFC'Position, AbsSyntax.Expr))
happyIn37 :: ((AbsSyntax.BNFC'Position, AbsSyntax.Expr)) -> (HappyAbsSyn )
happyIn37 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap37 x)
{-# INLINE happyIn37 #-}
happyOut37 :: (HappyAbsSyn ) -> HappyWrap37
happyOut37 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut37 #-}
newtype HappyWrap38 = HappyWrap38 ((AbsSyntax.BNFC'Position, AbsSyntax.Expr))
happyIn38 :: ((AbsSyntax.BNFC'Position, AbsSyntax.Expr)) -> (HappyAbsSyn )
happyIn38 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap38 x)
{-# INLINE happyIn38 #-}
happyOut38 :: (HappyAbsSyn ) -> HappyWrap38
happyOut38 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut38 #-}
newtype HappyWrap39 = HappyWrap39 ((AbsSyntax.BNFC'Position, AbsSyntax.Expr))
happyIn39 :: ((AbsSyntax.BNFC'Position, AbsSyntax.Expr)) -> (HappyAbsSyn )
happyIn39 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap39 x)
{-# INLINE happyIn39 #-}
happyOut39 :: (HappyAbsSyn ) -> HappyWrap39
happyOut39 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut39 #-}
newtype HappyWrap40 = HappyWrap40 ((AbsSyntax.BNFC'Position, AbsSyntax.Expr))
happyIn40 :: ((AbsSyntax.BNFC'Position, AbsSyntax.Expr)) -> (HappyAbsSyn )
happyIn40 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap40 x)
{-# INLINE happyIn40 #-}
happyOut40 :: (HappyAbsSyn ) -> HappyWrap40
happyOut40 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut40 #-}
newtype HappyWrap41 = HappyWrap41 ((AbsSyntax.BNFC'Position, AbsSyntax.Expr))
happyIn41 :: ((AbsSyntax.BNFC'Position, AbsSyntax.Expr)) -> (HappyAbsSyn )
happyIn41 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap41 x)
{-# INLINE happyIn41 #-}
happyOut41 :: (HappyAbsSyn ) -> HappyWrap41
happyOut41 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut41 #-}
newtype HappyWrap42 = HappyWrap42 ((AbsSyntax.BNFC'Position, AbsSyntax.Expr))
happyIn42 :: ((AbsSyntax.BNFC'Position, AbsSyntax.Expr)) -> (HappyAbsSyn )
happyIn42 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap42 x)
{-# INLINE happyIn42 #-}
happyOut42 :: (HappyAbsSyn ) -> HappyWrap42
happyOut42 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut42 #-}
newtype HappyWrap43 = HappyWrap43 ((AbsSyntax.BNFC'Position, AbsSyntax.Expr))
happyIn43 :: ((AbsSyntax.BNFC'Position, AbsSyntax.Expr)) -> (HappyAbsSyn )
happyIn43 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap43 x)
{-# INLINE happyIn43 #-}
happyOut43 :: (HappyAbsSyn ) -> HappyWrap43
happyOut43 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut43 #-}
newtype HappyWrap44 = HappyWrap44 ((AbsSyntax.BNFC'Position, [AbsSyntax.Expr]))
happyIn44 :: ((AbsSyntax.BNFC'Position, [AbsSyntax.Expr])) -> (HappyAbsSyn )
happyIn44 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap44 x)
{-# INLINE happyIn44 #-}
happyOut44 :: (HappyAbsSyn ) -> HappyWrap44
happyOut44 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut44 #-}
newtype HappyWrap45 = HappyWrap45 ((AbsSyntax.BNFC'Position, AbsSyntax.AddOp))
happyIn45 :: ((AbsSyntax.BNFC'Position, AbsSyntax.AddOp)) -> (HappyAbsSyn )
happyIn45 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap45 x)
{-# INLINE happyIn45 #-}
happyOut45 :: (HappyAbsSyn ) -> HappyWrap45
happyOut45 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut45 #-}
newtype HappyWrap46 = HappyWrap46 ((AbsSyntax.BNFC'Position, AbsSyntax.MulOp))
happyIn46 :: ((AbsSyntax.BNFC'Position, AbsSyntax.MulOp)) -> (HappyAbsSyn )
happyIn46 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap46 x)
{-# INLINE happyIn46 #-}
happyOut46 :: (HappyAbsSyn ) -> HappyWrap46
happyOut46 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut46 #-}
newtype HappyWrap47 = HappyWrap47 ((AbsSyntax.BNFC'Position, AbsSyntax.RelOp))
happyIn47 :: ((AbsSyntax.BNFC'Position, AbsSyntax.RelOp)) -> (HappyAbsSyn )
happyIn47 x = Happy_GHC_Exts.unsafeCoerce# (HappyWrap47 x)
{-# INLINE happyIn47 #-}
happyOut47 :: (HappyAbsSyn ) -> HappyWrap47
happyOut47 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut47 #-}
happyInTok :: (Token) -> (HappyAbsSyn )
happyInTok x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn ) -> (Token)
happyOutTok x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOutTok #-}


happyExpList :: HappyAddr
happyExpList = HappyA# "\x00\x00\x00\x00\x00\x80\x10\x0a\xbc\xbf\x73\x00\x00\x00\x00\x00\x80\x10\x0a\xbc\xbf\x73\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x80\x10\x0a\xbc\xbf\x73\x00\x00\x00\x00\x00\x00\x00\x00\x04\x24\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x24\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x24\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x24\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x24\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x24\x00\x00\x00\x00\x00\x00\x00\x10\x00\x80\x80\x70\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x00\x80\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x42\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\xb0\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x42\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x09\xb0\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x00\x80\x80\x70\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x00\x10\x00\x80\x80\x70\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\xb0\x03\x00\x00\x00\x00\x00\x00\x00\x00\x80\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x42\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x40\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x24\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x10\x0a\xbc\xbf\x73\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x10\x0a\xbc\xbf\x73\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x40\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x24\x00\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x00\x00\x00\x04\x24\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x24\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x24\x00\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x42\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x24\x00\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x00\x00\x40\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x40\x00\x00\x00\x00\x00\x00\x00\x00\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x10\x0a\xbc\xbf\x73\x00\x00\x00\x00\x00\x80\x10\x0a\xbc\xbf\x73\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x10\x0a\xbc\xbf\x73\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x40\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x10\x0a\xbc\xbf\x73\x00\x00\x00\x00\x00\x80\x10\x02\x80\x80\x70\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x10\x0a\xbc\xbf\x73\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_pProgram_internal","%start_pListStmt_internal","%start_pBlock_internal","%start_pStmt_internal","%start_pArgType_internal","%start_pListArgType_internal","%start_pArg_internal","%start_pListArg_internal","%start_pType_internal","%start_pListType_internal","%start_pExpr6_internal","%start_pExpr5_internal","%start_pExpr4_internal","%start_pExpr3_internal","%start_pExpr2_internal","%start_pExpr1_internal","%start_pExpr_internal","%start_pListExpr_internal","%start_pAddOp_internal","%start_pMulOp_internal","%start_pRelOp_internal","Ident","Integer","String","Program","ListStmt","Block","Stmt","ArgType","ListArgType","Arg","ListArg","Type","ListType","Expr6","Expr5","Expr4","Expr3","Expr2","Expr1","Expr","ListExpr","AddOp","MulOp","RelOp","'!'","'!='","'%'","'&'","'&&'","'('","')'","'*'","'+'","','","'-'","'/'","';'","'<'","'<='","'='","'=='","'>'","'>='","'bool'","'break'","'const'","'continue'","'else'","'false'","'for'","'if'","'int'","'print'","'return'","'string'","'to'","'true'","'while'","'{'","'||'","'}'","L_Ident","L_integ","L_quoted","%eof"]
        bit_start = st Prelude.* 88
        bit_end = (st Prelude.+ 1) Prelude.* 88
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..87]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\x01\x00\x01\x00\xe1\xff\x01\x00\xf5\xff\xf5\xff\xf5\xff\xf5\xff\xf5\xff\xf5\xff\x29\x00\x20\x00\x20\x00\x20\x00\x20\x00\x20\x00\x20\x00\x20\x00\x96\x00\x34\x00\x2c\x00\xe2\xff\x00\x00\xf0\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf0\xff\x00\x00\x00\x00\x00\x00\xf0\xff\x00\x00\x00\x00\x24\x00\x00\x00\x00\x00\x00\x00\x00\x00\x34\x00\x96\x00\x0a\x02\x14\x00\x3a\x00\x22\x00\x29\x00\x20\x00\x29\x00\x00\x00\x00\x00\x00\x00\x00\x00\x22\x00\x22\x00\x23\x00\x07\x00\x03\x00\x22\x00\x22\x00\xfb\xff\x22\x00\x00\x00\x00\x00\x00\x00\x04\x00\x28\x00\x4c\x00\x35\x00\xd7\x00\x35\x00\x53\x00\x4a\x00\x4a\x00\xfd\xff\x00\x00\x4a\x00\x0d\x00\x7e\x00\x00\x00\x81\x00\xf5\xff\x8e\x00\x72\x00\xa9\x00\x20\x00\x20\x00\xb0\x00\x01\x00\x8a\x00\x8a\x00\x01\x00\x8a\x00\x00\x00\x00\x00\x9e\x00\x20\x00\xba\x00\xbd\x00\x20\x00\xc9\x00\x00\x00\x0d\x00\x00\x00\x00\x00\x3d\x00\xf5\xff\x20\x00\x20\x00\xf5\xff\x00\x00\xf5\xff\x00\x00\xf5\xff\x20\x00\x20\x00\x20\x00\x00\x00\xd9\x00\x00\x00\x20\x00\x20\x00\x20\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd3\x00\x34\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe3\x00\xea\x00\xeb\x00\xf5\xff\x20\x00\xe4\x00\xef\x00\xf9\x00\x00\x00\x00\x00\xfd\x00\x00\x00\x01\x00\x01\x00\x20\x00\x20\x00\xf6\x00\xfe\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\xfb\x00\xe6\x00\xff\x00\x00\x00\x01\x00\x20\x00\x00\x00\x00\x00\x0c\x01\x00\x00\x01\x00\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\x84\x00\x98\x00\x0f\x01\xd4\x00\x3e\x00\x85\x00\x99\x00\x4e\x00\x0d\x01\xcc\x00\x3e\x02\x2c\x02\x26\x02\x11\x02\xfa\x01\xe1\x01\x3f\x01\x52\x00\x04\x01\x06\x01\x03\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x11\x01\x13\x01\x14\x01\x00\x00\x00\x00\x00\x00\x41\x02\x53\x01\x44\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x14\x01\x17\x01\x18\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2d\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x30\x01\x00\x00\x00\x00\x00\x00\x31\x01\x00\x00\x00\x00\x00\x00\x5a\x01\x6e\x01\x00\x00\xac\x00\x00\x00\x00\x00\xc0\x00\x00\x00\x00\x00\x00\x00\x00\x00\x75\x01\x00\x00\x00\x00\x89\x01\x3b\x01\x00\x00\x42\x01\x00\x00\x00\x00\x00\x00\xad\x00\x5a\x00\x90\x01\xc1\x00\x00\x00\x6b\x00\x00\x00\xe0\x00\x2f\x02\x29\x02\x15\x02\x00\x00\x00\x00\x00\x00\x6f\x00\xa4\x01\xf4\x01\x00\x00\x00\x00\x00\x00\x00\x00\x2f\x01\x40\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x70\x00\xab\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe8\x00\xfc\x00\xbf\x01\xc6\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x24\x01\xda\x01\x00\x00\x00\x00\x00\x00\x00\x00\x38\x01\x00\x00\x00\x00"#

happyAdjustOffset :: Happy_GHC_Exts.Int# -> Happy_GHC_Exts.Int#
happyAdjustOffset off = off

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\xe6\xff\xe6\xff\x00\x00\x00\x00\x00\x00\xd2\xff\x00\x00\xce\xff\x00\x00\xc7\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xb0\xff\x00\x00\x00\x00\x00\x00\x00\x00\xea\xff\x00\x00\xa3\xff\xa8\xff\xa7\xff\xa4\xff\xa6\xff\xa5\xff\x00\x00\xa9\xff\xab\xff\xaa\xff\x00\x00\xad\xff\xac\xff\xc4\xff\xc3\xff\xbf\xff\xbb\xff\xb9\xff\xb7\xff\xb5\xff\xb3\xff\xb1\xff\xaf\xff\x00\x00\x00\x00\x00\x00\x00\x00\xc1\xff\xc2\xff\xe9\xff\xe8\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc6\xff\x00\x00\xc9\xff\xcb\xff\xca\xff\x00\x00\x00\x00\xcd\xff\x00\x00\xd4\xff\x00\x00\xd1\xff\x00\x00\x00\x00\xc4\xff\xe2\xff\x00\x00\x00\x00\x00\x00\xe3\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe6\xff\x00\x00\x00\x00\xe6\xff\x00\x00\xe7\xff\xe5\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xdc\xff\x00\x00\xdd\xff\xd7\xff\x00\x00\xd2\xff\xb0\xff\x00\x00\xd2\xff\xd3\xff\xce\xff\xcf\xff\xc7\xff\x00\x00\x00\x00\x00\x00\xbd\xff\x00\x00\xbc\xff\xb0\xff\x00\x00\x00\x00\xb4\xff\xb2\xff\xae\xff\xbe\xff\xb6\xff\xb8\xff\xba\xff\xc5\xff\xcc\xff\xd0\xff\x00\x00\x00\x00\x00\x00\xce\xff\x00\x00\x00\x00\x00\x00\x00\x00\xd6\xff\xde\xff\x00\x00\xe4\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc8\xff\xc0\xff\xdf\xff\x00\x00\xe1\xff\x00\x00\x00\x00\xdb\xff\xd9\xff\x00\x00\x00\x00\xe0\xff\xd5\xff\x00\x00\xda\xff\x00\x00\xd8\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\x06\x00\x01\x00\x06\x00\x23\x00\x0a\x00\x03\x00\x06\x00\x26\x00\x14\x00\x06\x00\x08\x00\x0b\x00\x10\x00\x0d\x00\x0c\x00\x09\x00\x1c\x00\x0b\x00\x06\x00\x1f\x00\x14\x00\x15\x00\x16\x00\x17\x00\x29\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x01\x00\x21\x00\x22\x00\x23\x00\x02\x00\x06\x00\x26\x00\x27\x00\x28\x00\x06\x00\x0b\x00\x29\x00\x29\x00\x02\x00\x06\x00\x29\x00\x0e\x00\x0f\x00\x26\x00\x11\x00\x12\x00\x13\x00\x03\x00\x24\x00\x19\x00\x0e\x00\x0f\x00\x08\x00\x11\x00\x12\x00\x13\x00\x0c\x00\x21\x00\x19\x00\x06\x00\x0a\x00\x07\x00\x26\x00\x27\x00\x28\x00\x0b\x00\x21\x00\x29\x00\x29\x00\x10\x00\x26\x00\x26\x00\x27\x00\x28\x00\x00\x00\x01\x00\x02\x00\x07\x00\x0a\x00\x09\x00\x0a\x00\x0b\x00\x00\x00\x01\x00\x02\x00\x0a\x00\x29\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x01\x00\x02\x00\x07\x00\x29\x00\x09\x00\x0a\x00\x0b\x00\x07\x00\x06\x00\x09\x00\x0a\x00\x0b\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x0d\x00\x07\x00\x08\x00\x0d\x00\x0b\x00\x0b\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x00\x00\x01\x00\x02\x00\x0d\x00\x04\x00\x05\x00\x06\x00\x09\x00\x07\x00\x0b\x00\x09\x00\x0b\x00\x0b\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x00\x00\x01\x00\x02\x00\x06\x00\x04\x00\x05\x00\x06\x00\x29\x00\x07\x00\x08\x00\x06\x00\x0b\x00\x0b\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x00\x00\x01\x00\x02\x00\x25\x00\x04\x00\x05\x00\x06\x00\x0d\x00\x07\x00\x08\x00\x0d\x00\x0b\x00\x0b\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x00\x00\x01\x00\x02\x00\x0b\x00\x0c\x00\x05\x00\x06\x00\x04\x00\x09\x00\x06\x00\x0b\x00\x0b\x00\x07\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x00\x00\x01\x00\x02\x00\x0b\x00\x0c\x00\x05\x00\x06\x00\x26\x00\x0d\x00\x07\x00\x07\x00\x0b\x00\x10\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x00\x00\x01\x00\x02\x00\x10\x00\x07\x00\x05\x00\x06\x00\x0d\x00\x07\x00\x07\x00\x20\x00\x0b\x00\x0d\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x00\x00\x01\x00\x02\x00\x07\x00\x05\x00\x05\x00\x06\x00\x18\x00\x0b\x00\x15\x00\x17\x00\x0b\x00\x16\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x00\x00\x01\x00\x02\x00\x16\x00\x15\x00\x05\x00\x06\x00\x17\x00\x15\x00\x00\x00\x16\x00\x0b\x00\x00\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x00\x00\x01\x00\x02\x00\x00\x00\x0b\x00\x05\x00\x06\x00\x00\x00\x01\x00\x02\x00\x00\x00\x0b\x00\x15\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x00\x00\x01\x00\x02\x00\x16\x00\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\xff\xff\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x02\x00\xff\xff\xff\xff\x05\x00\xff\xff\x00\x00\x01\x00\x02\x00\xff\xff\x00\x00\x01\x00\x02\x00\x0e\x00\x0f\x00\xff\xff\x11\x00\x12\x00\x13\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x00\x00\x01\x00\x02\x00\x00\x00\x01\x00\x02\x00\x00\x00\x01\x00\x02\x00\x00\x00\x01\x00\x02\x00\xff\xff\x0d\x00\x0e\x00\x0f\x00\x0d\x00\x0e\x00\x0f\x00\x0d\x00\x0e\x00\xff\xff\x0d\x00\x0e\x00\x00\x00\x01\x00\x02\x00\x00\x00\x01\x00\x02\x00\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\xff\xff\x0d\x00\xff\xff\xff\xff\x0d\x00\xff\xff\xff\xff\x0d\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x6d\x00\x31\x00\x6e\x00\x5b\x00\x74\x00\x20\x00\x32\x00\x17\x00\x41\x00\x6d\x00\x21\x00\x33\x00\x6f\x00\x52\x00\x22\x00\x24\x00\x42\x00\x25\x00\x6d\x00\x43\x00\x41\x00\x53\x00\x54\x00\x55\x00\xff\xff\x34\x00\x56\x00\x57\x00\x42\x00\x58\x00\x59\x00\x43\x00\x31\x00\x35\x00\x5a\x00\x5b\x00\x19\x00\x32\x00\x17\x00\x36\x00\x37\x00\x6e\x00\x33\x00\xff\xff\xff\xff\x19\x00\x32\x00\xff\xff\x1a\x00\x1b\x00\x17\x00\x1c\x00\x1d\x00\x1e\x00\x20\x00\x7c\x00\x34\x00\x1a\x00\x1b\x00\x21\x00\x1c\x00\x1d\x00\x1e\x00\x22\x00\x35\x00\x34\x00\x8b\x00\x7b\x00\x4b\x00\x17\x00\x36\x00\x37\x00\x47\x00\x35\x00\xff\xff\xff\xff\x8c\x00\x17\x00\x17\x00\x36\x00\x37\x00\x25\x00\x26\x00\x27\x00\x44\x00\x72\x00\x45\x00\x46\x00\x47\x00\x25\x00\x26\x00\x27\x00\x70\x00\xff\xff\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x88\x00\x25\x00\x26\x00\x27\x00\x44\x00\xff\xff\x45\x00\x85\x00\x47\x00\x44\x00\x67\x00\x45\x00\x98\x00\x47\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x7f\x00\x4c\x00\x26\x00\x27\x00\x5e\x00\x5f\x00\x4d\x00\x5d\x00\x6b\x00\x49\x00\x4a\x00\x6a\x00\x4f\x00\x47\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x50\x00\x4c\x00\x26\x00\x27\x00\x68\x00\x5c\x00\x4d\x00\x5d\x00\x24\x00\x44\x00\x25\x00\x48\x00\x4f\x00\x47\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x50\x00\x4c\x00\x26\x00\x27\x00\x66\x00\x61\x00\x4d\x00\x5d\x00\xff\xff\x49\x00\x89\x00\x63\x00\x4f\x00\x47\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x50\x00\x4c\x00\x26\x00\x27\x00\x93\x00\x60\x00\x4d\x00\x5d\x00\x91\x00\x49\x00\x86\x00\x90\x00\x4f\x00\x47\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x50\x00\x4c\x00\x26\x00\x27\x00\x3e\x00\x3f\x00\x4d\x00\x4e\x00\x71\x00\x24\x00\x6d\x00\x25\x00\x4f\x00\x81\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x50\x00\x4c\x00\x26\x00\x27\x00\x3e\x00\x84\x00\x4d\x00\xa1\x00\x17\x00\x9c\x00\x9b\x00\x9a\x00\x4f\x00\x97\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x50\x00\x4c\x00\x26\x00\x27\x00\x96\x00\x95\x00\x4d\x00\xa0\x00\x9e\x00\x94\x00\x9d\x00\xa4\x00\x4f\x00\xa5\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x50\x00\x4c\x00\x26\x00\x27\x00\xa9\x00\x5b\x00\x4d\x00\xa5\x00\xa3\x00\x43\x00\x22\x00\x17\x00\x4f\x00\x1e\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x50\x00\x4c\x00\x26\x00\x27\x00\x74\x00\x75\x00\x4d\x00\xa7\x00\x76\x00\x75\x00\x72\x00\x74\x00\x4f\x00\x6b\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x50\x00\x4c\x00\x26\x00\x27\x00\x8d\x00\x68\x00\x4d\x00\xa9\x00\x25\x00\x26\x00\x27\x00\x8c\x00\x4f\x00\x75\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x50\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x37\x00\x25\x00\x26\x00\x27\x00\x74\x00\x00\x00\x00\x00\x00\x00\x25\x00\x26\x00\x27\x00\x00\x00\x00\x00\x00\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x78\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x64\x00\x25\x00\x26\x00\x27\x00\x00\x00\x00\x00\x00\x00\x00\x00\x25\x00\x26\x00\x27\x00\x00\x00\x00\x00\x00\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x63\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x91\x00\x25\x00\x26\x00\x27\x00\x00\x00\x00\x00\x00\x00\x00\x00\x25\x00\x26\x00\x27\x00\x00\x00\x00\x00\x00\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x8e\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x87\x00\x25\x00\x26\x00\x27\x00\x00\x00\x00\x00\x00\x00\x00\x00\x25\x00\x26\x00\x27\x00\x00\x00\x00\x00\x00\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x7e\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x97\x00\x25\x00\x26\x00\x27\x00\x00\x00\x00\x00\x00\x00\x00\x00\x25\x00\x26\x00\x27\x00\x00\x00\x00\x00\x00\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x9f\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x9e\x00\x25\x00\x26\x00\x27\x00\x00\x00\x00\x00\x00\x00\x00\x00\x25\x00\x26\x00\x27\x00\x00\x00\x00\x00\x00\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\xa6\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x38\x00\x25\x00\x26\x00\x27\x00\x00\x00\x00\x00\x00\x00\x25\x00\x26\x00\x27\x00\x00\x00\x00\x00\x00\x00\x00\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x7d\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x39\x00\x19\x00\x00\x00\x00\x00\x7d\x00\x00\x00\x25\x00\x26\x00\x27\x00\x00\x00\x25\x00\x26\x00\x27\x00\x1a\x00\x1b\x00\x00\x00\x1c\x00\x1d\x00\x1e\x00\x28\x00\x29\x00\x2a\x00\x3a\x00\x28\x00\x29\x00\x2a\x00\x81\x00\x25\x00\x26\x00\x27\x00\x25\x00\x26\x00\x27\x00\x25\x00\x26\x00\x27\x00\x25\x00\x26\x00\x27\x00\x00\x00\x28\x00\x29\x00\x3b\x00\x28\x00\x29\x00\x82\x00\x28\x00\x3c\x00\x00\x00\x28\x00\x83\x00\x25\x00\x26\x00\x27\x00\x25\x00\x26\x00\x27\x00\x25\x00\x26\x00\x27\x00\x00\x00\x00\x00\x00\x00\x00\x00\x3d\x00\x00\x00\x00\x00\x79\x00\x00\x00\x00\x00\x77\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = Happy_Data_Array.array (21, 92) [
	(21 , happyReduce_21),
	(22 , happyReduce_22),
	(23 , happyReduce_23),
	(24 , happyReduce_24),
	(25 , happyReduce_25),
	(26 , happyReduce_26),
	(27 , happyReduce_27),
	(28 , happyReduce_28),
	(29 , happyReduce_29),
	(30 , happyReduce_30),
	(31 , happyReduce_31),
	(32 , happyReduce_32),
	(33 , happyReduce_33),
	(34 , happyReduce_34),
	(35 , happyReduce_35),
	(36 , happyReduce_36),
	(37 , happyReduce_37),
	(38 , happyReduce_38),
	(39 , happyReduce_39),
	(40 , happyReduce_40),
	(41 , happyReduce_41),
	(42 , happyReduce_42),
	(43 , happyReduce_43),
	(44 , happyReduce_44),
	(45 , happyReduce_45),
	(46 , happyReduce_46),
	(47 , happyReduce_47),
	(48 , happyReduce_48),
	(49 , happyReduce_49),
	(50 , happyReduce_50),
	(51 , happyReduce_51),
	(52 , happyReduce_52),
	(53 , happyReduce_53),
	(54 , happyReduce_54),
	(55 , happyReduce_55),
	(56 , happyReduce_56),
	(57 , happyReduce_57),
	(58 , happyReduce_58),
	(59 , happyReduce_59),
	(60 , happyReduce_60),
	(61 , happyReduce_61),
	(62 , happyReduce_62),
	(63 , happyReduce_63),
	(64 , happyReduce_64),
	(65 , happyReduce_65),
	(66 , happyReduce_66),
	(67 , happyReduce_67),
	(68 , happyReduce_68),
	(69 , happyReduce_69),
	(70 , happyReduce_70),
	(71 , happyReduce_71),
	(72 , happyReduce_72),
	(73 , happyReduce_73),
	(74 , happyReduce_74),
	(75 , happyReduce_75),
	(76 , happyReduce_76),
	(77 , happyReduce_77),
	(78 , happyReduce_78),
	(79 , happyReduce_79),
	(80 , happyReduce_80),
	(81 , happyReduce_81),
	(82 , happyReduce_82),
	(83 , happyReduce_83),
	(84 , happyReduce_84),
	(85 , happyReduce_85),
	(86 , happyReduce_86),
	(87 , happyReduce_87),
	(88 , happyReduce_88),
	(89 , happyReduce_89),
	(90 , happyReduce_90),
	(91 , happyReduce_91),
	(92 , happyReduce_92)
	]

happy_n_terms = 42 :: Prelude.Int
happy_n_nonterms = 24 :: Prelude.Int

happyReduce_21 = happySpecReduce_1  0# happyReduction_21
happyReduction_21 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn24
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.Ident (tokenText happy_var_1))
	)}

happyReduce_22 = happySpecReduce_1  1# happyReduction_22
happyReduction_22 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn25
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), (read (tokenText happy_var_1)) :: Integer)
	)}

happyReduce_23 = happySpecReduce_1  2# happyReduction_23
happyReduction_23 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn26
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), ((\(PT _ (TL s)) -> s) happy_var_1))
	)}

happyReduce_24 = happySpecReduce_1  3# happyReduction_24
happyReduction_24 happy_x_1
	 =  case happyOut28 happy_x_1 of { (HappyWrap28 happy_var_1) -> 
	happyIn27
		 ((fst happy_var_1, AbsSyntax.Program (fst happy_var_1) (snd happy_var_1))
	)}

happyReduce_25 = happySpecReduce_0  4# happyReduction_25
happyReduction_25  =  happyIn28
		 ((AbsSyntax.BNFC'NoPosition, [])
	)

happyReduce_26 = happySpecReduce_2  4# happyReduction_26
happyReduction_26 happy_x_2
	happy_x_1
	 =  case happyOut30 happy_x_1 of { (HappyWrap30 happy_var_1) -> 
	case happyOut28 happy_x_2 of { (HappyWrap28 happy_var_2) -> 
	happyIn28
		 ((fst happy_var_1, (:) (snd happy_var_1) (snd happy_var_2))
	)}}

happyReduce_27 = happySpecReduce_3  5# happyReduction_27
happyReduction_27 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut28 happy_x_2 of { (HappyWrap28 happy_var_2) -> 
	happyIn29
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.Block (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)) (snd happy_var_2))
	)}}

happyReduce_28 = happySpecReduce_1  6# happyReduction_28
happyReduction_28 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn30
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.Empty (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)))
	)}

happyReduce_29 = happySpecReduce_1  6# happyReduction_29
happyReduction_29 happy_x_1
	 =  case happyOut29 happy_x_1 of { (HappyWrap29 happy_var_1) -> 
	happyIn30
		 ((fst happy_var_1, AbsSyntax.BStmt (fst happy_var_1) (snd happy_var_1))
	)}

happyReduce_30 = happyReduce 5# 6# happyReduction_30
happyReduction_30 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut35 happy_x_1 of { (HappyWrap35 happy_var_1) -> 
	case happyOut24 happy_x_2 of { (HappyWrap24 happy_var_2) -> 
	case happyOut43 happy_x_4 of { (HappyWrap43 happy_var_4) -> 
	happyIn30
		 ((fst happy_var_1, AbsSyntax.VarDecl (fst happy_var_1) (snd happy_var_1) (snd happy_var_2) (snd happy_var_4))
	) `HappyStk` happyRest}}}

happyReduce_31 = happyReduce 6# 6# happyReduction_31
happyReduction_31 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut35 happy_x_2 of { (HappyWrap35 happy_var_2) -> 
	case happyOut24 happy_x_3 of { (HappyWrap24 happy_var_3) -> 
	case happyOut43 happy_x_5 of { (HappyWrap43 happy_var_5) -> 
	happyIn30
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.ConstDecl (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)) (snd happy_var_2) (snd happy_var_3) (snd happy_var_5))
	) `HappyStk` happyRest}}}}

happyReduce_32 = happyReduce 4# 6# happyReduction_32
happyReduction_32 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut24 happy_x_1 of { (HappyWrap24 happy_var_1) -> 
	case happyOut43 happy_x_3 of { (HappyWrap43 happy_var_3) -> 
	happyIn30
		 ((fst happy_var_1, AbsSyntax.Ass (fst happy_var_1) (snd happy_var_1) (snd happy_var_3))
	) `HappyStk` happyRest}}

happyReduce_33 = happySpecReduce_3  6# happyReduction_33
happyReduction_33 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut43 happy_x_2 of { (HappyWrap43 happy_var_2) -> 
	happyIn30
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.Ret (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)) (snd happy_var_2))
	)}}

happyReduce_34 = happySpecReduce_2  6# happyReduction_34
happyReduction_34 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn30
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.Bre (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)))
	)}

happyReduce_35 = happySpecReduce_2  6# happyReduction_35
happyReduction_35 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn30
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.Cont (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)))
	)}

happyReduce_36 = happyReduce 5# 6# happyReduction_36
happyReduction_36 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut43 happy_x_3 of { (HappyWrap43 happy_var_3) -> 
	case happyOut30 happy_x_5 of { (HappyWrap30 happy_var_5) -> 
	happyIn30
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.If (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)) (snd happy_var_3) (snd happy_var_5))
	) `HappyStk` happyRest}}}

happyReduce_37 = happyReduce 7# 6# happyReduction_37
happyReduction_37 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut43 happy_x_3 of { (HappyWrap43 happy_var_3) -> 
	case happyOut30 happy_x_5 of { (HappyWrap30 happy_var_5) -> 
	case happyOut30 happy_x_7 of { (HappyWrap30 happy_var_7) -> 
	happyIn30
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.IfElse (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)) (snd happy_var_3) (snd happy_var_5) (snd happy_var_7))
	) `HappyStk` happyRest}}}}

happyReduce_38 = happyReduce 5# 6# happyReduction_38
happyReduction_38 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut43 happy_x_3 of { (HappyWrap43 happy_var_3) -> 
	case happyOut30 happy_x_5 of { (HappyWrap30 happy_var_5) -> 
	happyIn30
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.While (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)) (snd happy_var_3) (snd happy_var_5))
	) `HappyStk` happyRest}}}

happyReduce_39 = happyReduce 9# 6# happyReduction_39
happyReduction_39 (happy_x_9 `HappyStk`
	happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut24 happy_x_3 of { (HappyWrap24 happy_var_3) -> 
	case happyOut43 happy_x_5 of { (HappyWrap43 happy_var_5) -> 
	case happyOut43 happy_x_7 of { (HappyWrap43 happy_var_7) -> 
	case happyOut30 happy_x_9 of { (HappyWrap30 happy_var_9) -> 
	happyIn30
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.For (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)) (snd happy_var_3) (snd happy_var_5) (snd happy_var_7) (snd happy_var_9))
	) `HappyStk` happyRest}}}}}

happyReduce_40 = happySpecReduce_2  6# happyReduction_40
happyReduction_40 happy_x_2
	happy_x_1
	 =  case happyOut43 happy_x_1 of { (HappyWrap43 happy_var_1) -> 
	happyIn30
		 ((fst happy_var_1, AbsSyntax.SExp (fst happy_var_1) (snd happy_var_1))
	)}

happyReduce_41 = happySpecReduce_3  6# happyReduction_41
happyReduction_41 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut43 happy_x_2 of { (HappyWrap43 happy_var_2) -> 
	happyIn30
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.Print (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)) (snd happy_var_2))
	)}}

happyReduce_42 = happyReduce 6# 6# happyReduction_42
happyReduction_42 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut35 happy_x_1 of { (HappyWrap35 happy_var_1) -> 
	case happyOut24 happy_x_2 of { (HappyWrap24 happy_var_2) -> 
	case happyOut34 happy_x_4 of { (HappyWrap34 happy_var_4) -> 
	case happyOut30 happy_x_6 of { (HappyWrap30 happy_var_6) -> 
	happyIn30
		 ((fst happy_var_1, AbsSyntax.FnDef (fst happy_var_1) (snd happy_var_1) (snd happy_var_2) (snd happy_var_4) (snd happy_var_6))
	) `HappyStk` happyRest}}}}

happyReduce_43 = happySpecReduce_1  7# happyReduction_43
happyReduction_43 happy_x_1
	 =  case happyOut35 happy_x_1 of { (HappyWrap35 happy_var_1) -> 
	happyIn31
		 ((fst happy_var_1, AbsSyntax.ValArg (fst happy_var_1) (snd happy_var_1))
	)}

happyReduce_44 = happySpecReduce_2  7# happyReduction_44
happyReduction_44 happy_x_2
	happy_x_1
	 =  case happyOut35 happy_x_1 of { (HappyWrap35 happy_var_1) -> 
	happyIn31
		 ((fst happy_var_1, AbsSyntax.RefArg (fst happy_var_1) (snd happy_var_1))
	)}

happyReduce_45 = happySpecReduce_0  8# happyReduction_45
happyReduction_45  =  happyIn32
		 ((AbsSyntax.BNFC'NoPosition, [])
	)

happyReduce_46 = happySpecReduce_1  8# happyReduction_46
happyReduction_46 happy_x_1
	 =  case happyOut31 happy_x_1 of { (HappyWrap31 happy_var_1) -> 
	happyIn32
		 ((fst happy_var_1, (:[]) (snd happy_var_1))
	)}

happyReduce_47 = happySpecReduce_3  8# happyReduction_47
happyReduction_47 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut31 happy_x_1 of { (HappyWrap31 happy_var_1) -> 
	case happyOut32 happy_x_3 of { (HappyWrap32 happy_var_3) -> 
	happyIn32
		 ((fst happy_var_1, (:) (snd happy_var_1) (snd happy_var_3))
	)}}

happyReduce_48 = happySpecReduce_2  9# happyReduction_48
happyReduction_48 happy_x_2
	happy_x_1
	 =  case happyOut31 happy_x_1 of { (HappyWrap31 happy_var_1) -> 
	case happyOut24 happy_x_2 of { (HappyWrap24 happy_var_2) -> 
	happyIn33
		 ((fst happy_var_1, AbsSyntax.Arg (fst happy_var_1) (snd happy_var_1) (snd happy_var_2))
	)}}

happyReduce_49 = happySpecReduce_0  10# happyReduction_49
happyReduction_49  =  happyIn34
		 ((AbsSyntax.BNFC'NoPosition, [])
	)

happyReduce_50 = happySpecReduce_1  10# happyReduction_50
happyReduction_50 happy_x_1
	 =  case happyOut33 happy_x_1 of { (HappyWrap33 happy_var_1) -> 
	happyIn34
		 ((fst happy_var_1, (:[]) (snd happy_var_1))
	)}

happyReduce_51 = happySpecReduce_3  10# happyReduction_51
happyReduction_51 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut33 happy_x_1 of { (HappyWrap33 happy_var_1) -> 
	case happyOut34 happy_x_3 of { (HappyWrap34 happy_var_3) -> 
	happyIn34
		 ((fst happy_var_1, (:) (snd happy_var_1) (snd happy_var_3))
	)}}

happyReduce_52 = happySpecReduce_1  11# happyReduction_52
happyReduction_52 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn35
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.Int (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)))
	)}

happyReduce_53 = happySpecReduce_1  11# happyReduction_53
happyReduction_53 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn35
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.Str (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)))
	)}

happyReduce_54 = happySpecReduce_1  11# happyReduction_54
happyReduction_54 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn35
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.Bool (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)))
	)}

happyReduce_55 = happyReduce 4# 11# happyReduction_55
happyReduction_55 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut35 happy_x_1 of { (HappyWrap35 happy_var_1) -> 
	case happyOut32 happy_x_3 of { (HappyWrap32 happy_var_3) -> 
	happyIn35
		 ((fst happy_var_1, AbsSyntax.Fun (fst happy_var_1) (snd happy_var_1) (snd happy_var_3))
	) `HappyStk` happyRest}}

happyReduce_56 = happySpecReduce_0  12# happyReduction_56
happyReduction_56  =  happyIn36
		 ((AbsSyntax.BNFC'NoPosition, [])
	)

happyReduce_57 = happySpecReduce_1  12# happyReduction_57
happyReduction_57 happy_x_1
	 =  case happyOut35 happy_x_1 of { (HappyWrap35 happy_var_1) -> 
	happyIn36
		 ((fst happy_var_1, (:[]) (snd happy_var_1))
	)}

happyReduce_58 = happySpecReduce_3  12# happyReduction_58
happyReduction_58 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut35 happy_x_1 of { (HappyWrap35 happy_var_1) -> 
	case happyOut36 happy_x_3 of { (HappyWrap36 happy_var_3) -> 
	happyIn36
		 ((fst happy_var_1, (:) (snd happy_var_1) (snd happy_var_3))
	)}}

happyReduce_59 = happySpecReduce_1  13# happyReduction_59
happyReduction_59 happy_x_1
	 =  case happyOut24 happy_x_1 of { (HappyWrap24 happy_var_1) -> 
	happyIn37
		 ((fst happy_var_1, AbsSyntax.EVar (fst happy_var_1) (snd happy_var_1))
	)}

happyReduce_60 = happySpecReduce_1  13# happyReduction_60
happyReduction_60 happy_x_1
	 =  case happyOut25 happy_x_1 of { (HappyWrap25 happy_var_1) -> 
	happyIn37
		 ((fst happy_var_1, AbsSyntax.ELitInt (fst happy_var_1) (snd happy_var_1))
	)}

happyReduce_61 = happySpecReduce_1  13# happyReduction_61
happyReduction_61 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn37
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.ELitTrue (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)))
	)}

happyReduce_62 = happySpecReduce_1  13# happyReduction_62
happyReduction_62 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn37
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.ELitFalse (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)))
	)}

happyReduce_63 = happyReduce 4# 13# happyReduction_63
happyReduction_63 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut24 happy_x_1 of { (HappyWrap24 happy_var_1) -> 
	case happyOut44 happy_x_3 of { (HappyWrap44 happy_var_3) -> 
	happyIn37
		 ((fst happy_var_1, AbsSyntax.ECall (fst happy_var_1) (snd happy_var_1) (snd happy_var_3))
	) `HappyStk` happyRest}}

happyReduce_64 = happySpecReduce_1  13# happyReduction_64
happyReduction_64 happy_x_1
	 =  case happyOut26 happy_x_1 of { (HappyWrap26 happy_var_1) -> 
	happyIn37
		 ((fst happy_var_1, AbsSyntax.EString (fst happy_var_1) (snd happy_var_1))
	)}

happyReduce_65 = happySpecReduce_3  13# happyReduction_65
happyReduction_65 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut43 happy_x_2 of { (HappyWrap43 happy_var_2) -> 
	happyIn37
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), (snd happy_var_2))
	)}}

happyReduce_66 = happySpecReduce_2  14# happyReduction_66
happyReduction_66 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut37 happy_x_2 of { (HappyWrap37 happy_var_2) -> 
	happyIn38
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.Neg (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)) (snd happy_var_2))
	)}}

happyReduce_67 = happySpecReduce_2  14# happyReduction_67
happyReduction_67 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut37 happy_x_2 of { (HappyWrap37 happy_var_2) -> 
	happyIn38
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.Not (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)) (snd happy_var_2))
	)}}

happyReduce_68 = happySpecReduce_1  14# happyReduction_68
happyReduction_68 happy_x_1
	 =  case happyOut37 happy_x_1 of { (HappyWrap37 happy_var_1) -> 
	happyIn38
		 ((fst happy_var_1, (snd happy_var_1))
	)}

happyReduce_69 = happySpecReduce_3  15# happyReduction_69
happyReduction_69 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut39 happy_x_1 of { (HappyWrap39 happy_var_1) -> 
	case happyOut46 happy_x_2 of { (HappyWrap46 happy_var_2) -> 
	case happyOut38 happy_x_3 of { (HappyWrap38 happy_var_3) -> 
	happyIn39
		 ((fst happy_var_1, AbsSyntax.EMul (fst happy_var_1) (snd happy_var_1) (snd happy_var_2) (snd happy_var_3))
	)}}}

happyReduce_70 = happySpecReduce_1  15# happyReduction_70
happyReduction_70 happy_x_1
	 =  case happyOut38 happy_x_1 of { (HappyWrap38 happy_var_1) -> 
	happyIn39
		 ((fst happy_var_1, (snd happy_var_1))
	)}

happyReduce_71 = happySpecReduce_3  16# happyReduction_71
happyReduction_71 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut40 happy_x_1 of { (HappyWrap40 happy_var_1) -> 
	case happyOut45 happy_x_2 of { (HappyWrap45 happy_var_2) -> 
	case happyOut39 happy_x_3 of { (HappyWrap39 happy_var_3) -> 
	happyIn40
		 ((fst happy_var_1, AbsSyntax.EAdd (fst happy_var_1) (snd happy_var_1) (snd happy_var_2) (snd happy_var_3))
	)}}}

happyReduce_72 = happySpecReduce_1  16# happyReduction_72
happyReduction_72 happy_x_1
	 =  case happyOut39 happy_x_1 of { (HappyWrap39 happy_var_1) -> 
	happyIn40
		 ((fst happy_var_1, (snd happy_var_1))
	)}

happyReduce_73 = happySpecReduce_3  17# happyReduction_73
happyReduction_73 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_1 of { (HappyWrap41 happy_var_1) -> 
	case happyOut47 happy_x_2 of { (HappyWrap47 happy_var_2) -> 
	case happyOut40 happy_x_3 of { (HappyWrap40 happy_var_3) -> 
	happyIn41
		 ((fst happy_var_1, AbsSyntax.ERel (fst happy_var_1) (snd happy_var_1) (snd happy_var_2) (snd happy_var_3))
	)}}}

happyReduce_74 = happySpecReduce_1  17# happyReduction_74
happyReduction_74 happy_x_1
	 =  case happyOut40 happy_x_1 of { (HappyWrap40 happy_var_1) -> 
	happyIn41
		 ((fst happy_var_1, (snd happy_var_1))
	)}

happyReduce_75 = happySpecReduce_3  18# happyReduction_75
happyReduction_75 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_1 of { (HappyWrap41 happy_var_1) -> 
	case happyOut42 happy_x_3 of { (HappyWrap42 happy_var_3) -> 
	happyIn42
		 ((fst happy_var_1, AbsSyntax.EAnd (fst happy_var_1) (snd happy_var_1) (snd happy_var_3))
	)}}

happyReduce_76 = happySpecReduce_1  18# happyReduction_76
happyReduction_76 happy_x_1
	 =  case happyOut41 happy_x_1 of { (HappyWrap41 happy_var_1) -> 
	happyIn42
		 ((fst happy_var_1, (snd happy_var_1))
	)}

happyReduce_77 = happySpecReduce_3  19# happyReduction_77
happyReduction_77 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut42 happy_x_1 of { (HappyWrap42 happy_var_1) -> 
	case happyOut43 happy_x_3 of { (HappyWrap43 happy_var_3) -> 
	happyIn43
		 ((fst happy_var_1, AbsSyntax.EOr (fst happy_var_1) (snd happy_var_1) (snd happy_var_3))
	)}}

happyReduce_78 = happySpecReduce_1  19# happyReduction_78
happyReduction_78 happy_x_1
	 =  case happyOut42 happy_x_1 of { (HappyWrap42 happy_var_1) -> 
	happyIn43
		 ((fst happy_var_1, (snd happy_var_1))
	)}

happyReduce_79 = happySpecReduce_0  20# happyReduction_79
happyReduction_79  =  happyIn44
		 ((AbsSyntax.BNFC'NoPosition, [])
	)

happyReduce_80 = happySpecReduce_1  20# happyReduction_80
happyReduction_80 happy_x_1
	 =  case happyOut43 happy_x_1 of { (HappyWrap43 happy_var_1) -> 
	happyIn44
		 ((fst happy_var_1, (:[]) (snd happy_var_1))
	)}

happyReduce_81 = happySpecReduce_3  20# happyReduction_81
happyReduction_81 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut43 happy_x_1 of { (HappyWrap43 happy_var_1) -> 
	case happyOut44 happy_x_3 of { (HappyWrap44 happy_var_3) -> 
	happyIn44
		 ((fst happy_var_1, (:) (snd happy_var_1) (snd happy_var_3))
	)}}

happyReduce_82 = happySpecReduce_1  21# happyReduction_82
happyReduction_82 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn45
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.Plus (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)))
	)}

happyReduce_83 = happySpecReduce_1  21# happyReduction_83
happyReduction_83 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn45
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.Minus (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)))
	)}

happyReduce_84 = happySpecReduce_1  22# happyReduction_84
happyReduction_84 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn46
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.Times (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)))
	)}

happyReduce_85 = happySpecReduce_1  22# happyReduction_85
happyReduction_85 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn46
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.Div (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)))
	)}

happyReduce_86 = happySpecReduce_1  22# happyReduction_86
happyReduction_86 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn46
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.Mod (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)))
	)}

happyReduce_87 = happySpecReduce_1  23# happyReduction_87
happyReduction_87 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn47
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.LTH (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)))
	)}

happyReduce_88 = happySpecReduce_1  23# happyReduction_88
happyReduction_88 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn47
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.LE (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)))
	)}

happyReduce_89 = happySpecReduce_1  23# happyReduction_89
happyReduction_89 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn47
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.GTH (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)))
	)}

happyReduce_90 = happySpecReduce_1  23# happyReduction_90
happyReduction_90 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn47
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.GE (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)))
	)}

happyReduce_91 = happySpecReduce_1  23# happyReduction_91
happyReduction_91 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn47
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.EQU (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)))
	)}

happyReduce_92 = happySpecReduce_1  23# happyReduction_92
happyReduction_92 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn47
		 ((uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1), AbsSyntax.NE (uncurry AbsSyntax.BNFC'Position (tokenLineCol happy_var_1)))
	)}

happyNewToken action sts stk [] =
	happyDoAction 41# notHappyAtAll action sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = happyDoAction i tk action sts stk tks in
	case tk of {
	PT _ (TS _ 1) -> cont 1#;
	PT _ (TS _ 2) -> cont 2#;
	PT _ (TS _ 3) -> cont 3#;
	PT _ (TS _ 4) -> cont 4#;
	PT _ (TS _ 5) -> cont 5#;
	PT _ (TS _ 6) -> cont 6#;
	PT _ (TS _ 7) -> cont 7#;
	PT _ (TS _ 8) -> cont 8#;
	PT _ (TS _ 9) -> cont 9#;
	PT _ (TS _ 10) -> cont 10#;
	PT _ (TS _ 11) -> cont 11#;
	PT _ (TS _ 12) -> cont 12#;
	PT _ (TS _ 13) -> cont 13#;
	PT _ (TS _ 14) -> cont 14#;
	PT _ (TS _ 15) -> cont 15#;
	PT _ (TS _ 16) -> cont 16#;
	PT _ (TS _ 17) -> cont 17#;
	PT _ (TS _ 18) -> cont 18#;
	PT _ (TS _ 19) -> cont 19#;
	PT _ (TS _ 20) -> cont 20#;
	PT _ (TS _ 21) -> cont 21#;
	PT _ (TS _ 22) -> cont 22#;
	PT _ (TS _ 23) -> cont 23#;
	PT _ (TS _ 24) -> cont 24#;
	PT _ (TS _ 25) -> cont 25#;
	PT _ (TS _ 26) -> cont 26#;
	PT _ (TS _ 27) -> cont 27#;
	PT _ (TS _ 28) -> cont 28#;
	PT _ (TS _ 29) -> cont 29#;
	PT _ (TS _ 30) -> cont 30#;
	PT _ (TS _ 31) -> cont 31#;
	PT _ (TS _ 32) -> cont 32#;
	PT _ (TS _ 33) -> cont 33#;
	PT _ (TS _ 34) -> cont 34#;
	PT _ (TS _ 35) -> cont 35#;
	PT _ (TS _ 36) -> cont 36#;
	PT _ (TS _ 37) -> cont 37#;
	PT _ (TV _) -> cont 38#;
	PT _ (TI _) -> cont 39#;
	PT _ (TL _) -> cont 40#;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 41# tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

happyThen :: () => Err a -> (a -> Err b) -> Err b
happyThen = ((>>=))
happyReturn :: () => a -> Err a
happyReturn = (return)
happyThen1 m k tks = ((>>=)) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Err a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Token)], [Prelude.String]) -> Err a
happyError' = (\(tokens, _) -> happyError tokens)
pProgram_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 0# tks) (\x -> happyReturn (let {(HappyWrap27 x') = happyOut27 x} in x'))

pListStmt_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 1# tks) (\x -> happyReturn (let {(HappyWrap28 x') = happyOut28 x} in x'))

pBlock_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 2# tks) (\x -> happyReturn (let {(HappyWrap29 x') = happyOut29 x} in x'))

pStmt_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 3# tks) (\x -> happyReturn (let {(HappyWrap30 x') = happyOut30 x} in x'))

pArgType_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 4# tks) (\x -> happyReturn (let {(HappyWrap31 x') = happyOut31 x} in x'))

pListArgType_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 5# tks) (\x -> happyReturn (let {(HappyWrap32 x') = happyOut32 x} in x'))

pArg_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 6# tks) (\x -> happyReturn (let {(HappyWrap33 x') = happyOut33 x} in x'))

pListArg_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 7# tks) (\x -> happyReturn (let {(HappyWrap34 x') = happyOut34 x} in x'))

pType_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 8# tks) (\x -> happyReturn (let {(HappyWrap35 x') = happyOut35 x} in x'))

pListType_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 9# tks) (\x -> happyReturn (let {(HappyWrap36 x') = happyOut36 x} in x'))

pExpr6_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 10# tks) (\x -> happyReturn (let {(HappyWrap37 x') = happyOut37 x} in x'))

pExpr5_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 11# tks) (\x -> happyReturn (let {(HappyWrap38 x') = happyOut38 x} in x'))

pExpr4_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 12# tks) (\x -> happyReturn (let {(HappyWrap39 x') = happyOut39 x} in x'))

pExpr3_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 13# tks) (\x -> happyReturn (let {(HappyWrap40 x') = happyOut40 x} in x'))

pExpr2_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 14# tks) (\x -> happyReturn (let {(HappyWrap41 x') = happyOut41 x} in x'))

pExpr1_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 15# tks) (\x -> happyReturn (let {(HappyWrap42 x') = happyOut42 x} in x'))

pExpr_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 16# tks) (\x -> happyReturn (let {(HappyWrap43 x') = happyOut43 x} in x'))

pListExpr_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 17# tks) (\x -> happyReturn (let {(HappyWrap44 x') = happyOut44 x} in x'))

pAddOp_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 18# tks) (\x -> happyReturn (let {(HappyWrap45 x') = happyOut45 x} in x'))

pMulOp_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 19# tks) (\x -> happyReturn (let {(HappyWrap46 x') = happyOut46 x} in x'))

pRelOp_internal tks = happySomeParser where
 happySomeParser = happyThen (happyParse 20# tks) (\x -> happyReturn (let {(HappyWrap47 x') = happyOut47 x} in x'))

happySeq = happyDontSeq


type Err = Either String

happyError :: [Token] -> Err a
happyError ts = Left $
  "syntax error at " ++ tokenPos ts ++
  case ts of
    []      -> []
    [Err _] -> " due to lexer error"
    t:_     -> " before `" ++ (prToken t) ++ "'"

myLexer :: String -> [Token]
myLexer = tokens

-- Entrypoints

pProgram :: [Token] -> Err AbsSyntax.Program
pProgram = fmap snd . pProgram_internal

pListStmt :: [Token] -> Err [AbsSyntax.Stmt]
pListStmt = fmap snd . pListStmt_internal

pBlock :: [Token] -> Err AbsSyntax.Block
pBlock = fmap snd . pBlock_internal

pStmt :: [Token] -> Err AbsSyntax.Stmt
pStmt = fmap snd . pStmt_internal

pArgType :: [Token] -> Err AbsSyntax.ArgType
pArgType = fmap snd . pArgType_internal

pListArgType :: [Token] -> Err [AbsSyntax.ArgType]
pListArgType = fmap snd . pListArgType_internal

pArg :: [Token] -> Err AbsSyntax.Arg
pArg = fmap snd . pArg_internal

pListArg :: [Token] -> Err [AbsSyntax.Arg]
pListArg = fmap snd . pListArg_internal

pType :: [Token] -> Err AbsSyntax.Type
pType = fmap snd . pType_internal

pListType :: [Token] -> Err [AbsSyntax.Type]
pListType = fmap snd . pListType_internal

pExpr6 :: [Token] -> Err AbsSyntax.Expr
pExpr6 = fmap snd . pExpr6_internal

pExpr5 :: [Token] -> Err AbsSyntax.Expr
pExpr5 = fmap snd . pExpr5_internal

pExpr4 :: [Token] -> Err AbsSyntax.Expr
pExpr4 = fmap snd . pExpr4_internal

pExpr3 :: [Token] -> Err AbsSyntax.Expr
pExpr3 = fmap snd . pExpr3_internal

pExpr2 :: [Token] -> Err AbsSyntax.Expr
pExpr2 = fmap snd . pExpr2_internal

pExpr1 :: [Token] -> Err AbsSyntax.Expr
pExpr1 = fmap snd . pExpr1_internal

pExpr :: [Token] -> Err AbsSyntax.Expr
pExpr = fmap snd . pExpr_internal

pListExpr :: [Token] -> Err [AbsSyntax.Expr]
pListExpr = fmap snd . pListExpr_internal

pAddOp :: [Token] -> Err AbsSyntax.AddOp
pAddOp = fmap snd . pAddOp_internal

pMulOp :: [Token] -> Err AbsSyntax.MulOp
pMulOp = fmap snd . pMulOp_internal

pRelOp :: [Token] -> Err AbsSyntax.RelOp
pRelOp = fmap snd . pRelOp_internal
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $













-- Do not remove this comment. Required to fix CPP parsing when using GCC and a clang-compiled alex.
#if __GLASGOW_HASKELL__ > 706
#define LT(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.<# m)) :: Prelude.Bool)
#define GTE(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.>=# m)) :: Prelude.Bool)
#define EQ(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.==# m)) :: Prelude.Bool)
#else
#define LT(n,m) (n Happy_GHC_Exts.<# m)
#define GTE(n,m) (n Happy_GHC_Exts.>=# m)
#define EQ(n,m) (n Happy_GHC_Exts.==# m)
#endif



















data Happy_IntList = HappyCons Happy_GHC_Exts.Int# Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept 0# tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
        (happyTcHack j (happyTcHack st)) (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action



happyDoAction i tk st
        = {- nothing -}
          case action of
                0#           -> {- nothing -}
                                     happyFail (happyExpListPerState ((Happy_GHC_Exts.I# (st)) :: Prelude.Int)) i tk st
                -1#          -> {- nothing -}
                                     happyAccept i tk st
                n | LT(n,(0# :: Happy_GHC_Exts.Int#)) -> {- nothing -}
                                                   (happyReduceArr Happy_Data_Array.! rule) i tk st
                                                   where rule = (Happy_GHC_Exts.I# ((Happy_GHC_Exts.negateInt# ((n Happy_GHC_Exts.+# (1# :: Happy_GHC_Exts.Int#))))))
                n                 -> {- nothing -}
                                     happyShift new_state i tk st
                                     where new_state = (n Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#))
   where off    = happyAdjustOffset (indexShortOffAddr happyActOffsets st)
         off_i  = (off Happy_GHC_Exts.+# i)
         check  = if GTE(off_i,(0# :: Happy_GHC_Exts.Int#))
                  then EQ(indexShortOffAddr happyCheck off_i, i)
                  else Prelude.False
         action
          | check     = indexShortOffAddr happyTable off_i
          | Prelude.otherwise = indexShortOffAddr happyDefActions st




indexShortOffAddr (HappyA# arr) off =
        Happy_GHC_Exts.narrow16Int# i
  where
        i = Happy_GHC_Exts.word2Int# (Happy_GHC_Exts.or# (Happy_GHC_Exts.uncheckedShiftL# high 8#) low)
        high = Happy_GHC_Exts.int2Word# (Happy_GHC_Exts.ord# (Happy_GHC_Exts.indexCharOffAddr# arr (off' Happy_GHC_Exts.+# 1#)))
        low  = Happy_GHC_Exts.int2Word# (Happy_GHC_Exts.ord# (Happy_GHC_Exts.indexCharOffAddr# arr off'))
        off' = off Happy_GHC_Exts.*# 2#




{-# INLINE happyLt #-}
happyLt x y = LT(x,y)


readArrayBit arr bit =
    Bits.testBit (Happy_GHC_Exts.I# (indexShortOffAddr arr ((unbox_int bit) `Happy_GHC_Exts.iShiftRA#` 4#))) (bit `Prelude.mod` 16)
  where unbox_int (Happy_GHC_Exts.I# x) = x






data HappyAddr = HappyA# Happy_GHC_Exts.Addr#


-----------------------------------------------------------------------------
-- HappyState data type (not arrays)













-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state 0# tk st sts stk@(x `HappyStk` _) =
     let i = (case Happy_GHC_Exts.unsafeCoerce# x of { (Happy_GHC_Exts.I# (i)) -> i }) in
--     trace "shifting the error token" $
     happyDoAction i tk new_state (HappyCons (st) (sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state (HappyCons (st) (sts)) ((happyInTok (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happySpecReduce_0 nt fn j tk st@((action)) sts stk
     = happyGoto nt j tk st (HappyCons (st) (sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@((HappyCons (st@(action)) (_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happySpecReduce_2 nt fn j tk _ (HappyCons (_) (sts@((HappyCons (st@(action)) (_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happySpecReduce_3 nt fn j tk _ (HappyCons (_) ((HappyCons (_) (sts@((HappyCons (st@(action)) (_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#)) sts of
         sts1@((HappyCons (st1@(action)) (_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (happyGoto nt j tk st1 sts1 r)

happyMonadReduce k nt fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons (st) (sts)) of
        sts1@((HappyCons (st1@(action)) (_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> happyGoto nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn 0# tk st sts stk
     = happyFail [] 0# tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons (st) (sts)) of
        sts1@((HappyCons (st1@(action)) (_))) ->
         let drop_stk = happyDropStk k stk

             off = happyAdjustOffset (indexShortOffAddr happyGotoOffsets st1)
             off_i = (off Happy_GHC_Exts.+# nt)
             new_state = indexShortOffAddr happyTable off_i




          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop 0# l = l
happyDrop n (HappyCons (_) (t)) = happyDrop (n Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#)) t

happyDropStk 0# l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Happy_GHC_Exts.-# (1#::Happy_GHC_Exts.Int#)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction


happyGoto nt j tk st = 
   {- nothing -}
   happyDoAction j tk new_state
   where off = happyAdjustOffset (indexShortOffAddr happyGotoOffsets st)
         off_i = (off Happy_GHC_Exts.+# nt)
         new_state = indexShortOffAddr happyTable off_i




-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist 0# tk old_st _ stk@(x `HappyStk` _) =
     let i = (case Happy_GHC_Exts.unsafeCoerce# x of { (Happy_GHC_Exts.I# (i)) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (action) sts stk =
--      trace "entering error recovery" $
        happyDoAction 0# tk action sts ((Happy_GHC_Exts.unsafeCoerce# (Happy_GHC_Exts.I# (i))) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions


happyTcHack :: Happy_GHC_Exts.Int# -> a -> a
happyTcHack x y = y
{-# INLINE happyTcHack #-}


-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.


{-# NOINLINE happyDoAction #-}
{-# NOINLINE happyTable #-}
{-# NOINLINE happyCheck #-}
{-# NOINLINE happyActOffsets #-}
{-# NOINLINE happyGotoOffsets #-}
{-# NOINLINE happyDefActions #-}

{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
