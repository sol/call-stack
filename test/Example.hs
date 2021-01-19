{-# LANGUAGE CPP, FlexibleContexts #-}

#if __GLASGOW_HASKELL__ >= 704
{-# LANGUAGE ConstraintKinds #-}
#define HCS HasCallStack =>
#else
#define HCS
#endif
module Example where

import           Data.CallStack

test :: CallStack
test = foo

foo :: HCS CallStack
foo = bar

bar :: HCS CallStack
bar = callStack
