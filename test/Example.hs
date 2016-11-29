{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ConstraintKinds #-}
module Example where

import           Data.CallStack

test :: CallStack
test = foo

frozen :: CallStack
frozen = withFrozenCallStack foo

foo :: HasCallStack => CallStack
foo = bar

bar :: HasCallStack => CallStack
bar = callStack
