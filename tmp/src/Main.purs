module Main where

import Prelude
import DataBase.DB (get_xs_by_id)
import Effect (Effect)
import Hby.Task (runTask_)
import Hby.Task as Task
import Lib.Lib (initEnv, testFun)

main :: Effect Unit
main =
  runTask_ do
    initEnv
    testFun
    r <- get_xs_by_id 1
    Task.log $ show $ r
    Task.log "🍝"
