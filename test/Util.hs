{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
module Util (SrcLoc(..), mapLocations) where

import           Data.CallStack

#if MIN_VERSION_base(4,9,0)
import           GHC.Stack (SrcLoc(..))
mapLocation = id
#elif MIN_VERSION_base(4,8,1)

import qualified GHC.SrcLoc as GHC

data SrcLoc = SrcLoc {
  srcLocPackage :: String
, srcLocModule :: String
, srcLocFile :: String
, srcLocStartLine :: Int
, srcLocStartCol :: Int
, srcLocEndLine :: Int
, srcLocEndCol :: Int
} deriving (Eq, Show)

mapLocation location = SrcLoc {
  srcLocPackage = GHC.srcLocPackage location
, srcLocModule = GHC.srcLocModule location
, srcLocFile = GHC.srcLocFile location
, srcLocStartLine = GHC.srcLocStartLine location
, srcLocStartCol = GHC.srcLocStartCol location
, srcLocEndLine = GHC.srcLocEndLine location
, srcLocEndCol = GHC.srcLocEndCol location
}

#else
mapLocation = id
#endif

mapLocations :: CallStack -> [(String, SrcLoc)]
mapLocations = map (fmap mapLocation)
