module Lib.Lib where

import Prelude
import Hby.Task (Task)

foreign import testFun :: Task Unit

foreign import initEnv :: Task Unit
