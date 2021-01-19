{-# LANGUAGE CPP #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE ImplicitParams #-}

#if __GLASGOW_HASKELL__ >= 704
{-# LANGUAGE ConstraintKinds #-}
#define HCS HasCallStack =>
#else
#define HCS
#endif

module Data.CallStack (
#if __GLASGOW_HASKELL__ >= 704
  HasCallStack,
#endif
  CallStack
, SrcLoc(..)
, callStack
, callSite
) where

import Data.Maybe
import Data.SrcLoc

#if MIN_VERSION_base(4,8,1)
import qualified GHC.Stack as GHC
#endif

#if MIN_VERSION_base(4,9,0)
import           GHC.Stack (HasCallStack)
#elif MIN_VERSION_base(4,8,1)
type HasCallStack = (?callStack :: GHC.CallStack)
#elif __GLASGOW_HASKELL__ >= 704
import GHC.Exts (Constraint)
type HasCallStack = (() :: Constraint)
#endif

type CallStack = [(String, SrcLoc)]

callStack :: HCS CallStack
#if MIN_VERSION_base(4,9,0)
callStack = drop 1 $ GHC.getCallStack GHC.callStack
#elif MIN_VERSION_base(4,8,1)
callStack = drop 2 $ GHC.getCallStack ?callStack
#else
callStack = []
#endif

callSite :: HCS Maybe (String, SrcLoc)
callSite = listToMaybe (reverse callStack)
