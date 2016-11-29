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
            , srcLocStartLine = 14
            , srcLocStartCol = 7
            , srcLocEndLine = 14
            , srcLocEndCol = 10
            }
          )
        , ("foo"
          , SrcLoc {
              srcLocPackage = "main"
            , srcLocModule = "Example"
            , srcLocFile = "test/Example.hs"
            , srcLocStartLine = 8
            , srcLocStartCol = 8
            , srcLocEndLine = 8
            , srcLocEndCol = 11
            }
          )
#endif
        ]

  describe "withFrozenCallStack" $ do
    it "prevents new entries from being added to the call stack" $
      mapLocations frozen `shouldBe` [
#if MIN_VERSION_base(4,8,1) && !MIN_VERSION_base(4,9,0)
        ("bar"
        , SrcLoc {
            srcLocPackage = "main"
          , srcLocModule = "Example"
          , srcLocFile = "test/Example.hs"
          , srcLocStartLine = 14
          , srcLocStartCol = 7
          , srcLocEndLine = 14
          , srcLocEndCol = 10
          }
        )
      , ("foo"
        , SrcLoc {
            srcLocPackage = "main"
          , srcLocModule = "Example"
          , srcLocFile = "test/Example.hs"
          , srcLocStartLine = 11
          , srcLocStartCol = 30
          , srcLocEndLine = 11
          , srcLocEndCol = 33
          }
        )
#endif
      ]
