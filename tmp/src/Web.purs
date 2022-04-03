module Web where

import Prelude
import Effect (Effect)
import Hby.React.Grid (GridItemArea(..), GridSize(..))
import Hby.Task (Task, runTask_)
import Model.Counter (Counter(..))
import Model.CounterF (CounterF(..))
import Model.Screen (Screen(..), addItem, mkScreenNilItem)
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
    S.render
      $ Screen
          { rowSize: [ GridSize_Fr 1, GridSize_Fr 1, GridSize_Fr 1 ]
          , colSize: [ GridSize_Fr 1, GridSize_Fr 1 ]
          , item:
              identity
                $ addItem { area: GridItemArea 0 0 1 1, obj: counter }
                $ addItem { area: GridItemArea 1 1 2 2, obj: counterF }
                $ addItem { area: GridItemArea 0 2 2 3, obj: testButton }
                $ mkScreenNilItem
          }
