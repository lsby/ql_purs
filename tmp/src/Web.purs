module Web where

import Prelude
import Effect (Effect)
import Hby.Task (runTask_)
import Model.Screen (Screen(..), render)

main :: Effect Unit
main = runTask_ $ render $ Screen { n: 0.0 }
