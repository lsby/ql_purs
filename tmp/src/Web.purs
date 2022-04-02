module Web where

import Prelude
import Effect (Effect)
import Hby.Task (Task, runTask_)
import Model.Counter (Counter(..))
import Model.CounterF (CounterF(..))
import Model.Screen (Screen(..))
import Model.Screen (render) as S
import Model.TestButton (TestButton(..))

main :: Effect Unit
main = runTask_ $ render { n: 0.0 }
  where
  render :: { n :: Number } -> Task Unit
  render { n } = do
    counter <- pure $ Counter { n, addEvent: \n' -> render { n: n' } }
    counterF <- pure $ CounterF { n, onClick: \n' -> render { n: n' } }
    testButton <- pure $ TestButton unit
    S.render $ Screen { counter, counterF, testButton }
