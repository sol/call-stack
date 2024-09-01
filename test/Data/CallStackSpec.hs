{-# LANGUAGE CPP #-}
module Data.CallStackSpec (spec) where

import           Test.Hspec
import           Util
import           Example

spec :: Spec
spec = do
  describe "callStack" $ do
    it "returns the call stack" $ do
#if MIN_VERSION_base(4,18,0)
      let srcLocPackage' = "call-stack-0.4.0-inplace-spec"
#else
      let srcLocPackage' = "main"
#endif
      mapLocations test `shouldBe` [
#if MIN_VERSION_base(4,8,1)
          ("bar"
          , SrcLoc {
              srcLocPackage = srcLocPackage'
            , srcLocModule = "Example"
            , srcLocFile = "test" </> "Example.hs"
            , srcLocStartLine = 18
            , srcLocStartCol = 7
            , srcLocEndLine = 18
            , srcLocEndCol = 10
            }
          )
        , ("foo"
          , SrcLoc {
              srcLocPackage = srcLocPackage'
            , srcLocModule = "Example"
            , srcLocFile = "test" </> "Example.hs"
            , srcLocStartLine = 15
            , srcLocStartCol = 8
            , srcLocEndLine = 15
            , srcLocEndCol = 11
            }
          )
#endif
        ]
