module Web where

import Prelude
import Effect (Effect)
import Hby.Task (runTask_)
import Model.Demo.Demo (render) as Demo
import Model.Demo.Demo (mkDemo)

main :: Effect Unit
main = runTask_ $ Demo.render $ mkDemo
