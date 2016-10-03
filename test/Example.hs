{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ConstraintKinds #-}
module Example where

import           Data.CallStack

test :: CallStack
test = foo

foo :: HasCallStack => CallStack
foo = bar

bar :: HasCallStack => CallStack
bar = callStack
