{-# LANGUAGE CPP #-}
module Data.CallStackSpec (spec) where

import           Test.Hspec
import           Util
import           Example

spec :: Spec
spec = do
  describe "callStack" $ do
    it "returns the call stack" $ do
      mapLocations test `shouldBe` [
#if MIN_VERSION_base(4,8,1)
          ("bar"
          , SrcLoc {
              srcLocPackage = "main"
            , srcLocModule = "Example"
            , srcLocFile = "test/Example.hs"
            , srcLocStartLine = 17
            , srcLocStartCol = 7
            , srcLocEndLine = 17
            , srcLocEndCol = 10
            }
          )
        , ("foo"
          , SrcLoc {
              srcLocPackage = "main"
            , srcLocModule = "Example"
            , srcLocFile = "test/Example.hs"
            , srcLocStartLine = 14
            , srcLocStartCol = 8
            , srcLocEndLine = 14
            , srcLocEndCol = 11
            }
          )
#endif
        ]
