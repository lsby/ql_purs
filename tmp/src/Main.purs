module Main where

import Prelude
import Effect (Effect)
import Effect.Class.Console (log)
import Lib.Lib (testFun)

main :: Effect Unit
main = do
  testFun
  log "🍝"
