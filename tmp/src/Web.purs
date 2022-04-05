module Web where

import Prelude
import Effect (Effect)
import Hby.Task (runTask_)
import Model.Demo.Main (render) as Demo
import Model.Demo.Main (mkDemo)

main :: Effect Unit
main = runTask_ $ Demo.render $ mkDemo
