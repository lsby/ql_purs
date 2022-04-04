module Web where

import Prelude
import Effect (Effect)
import Hby.React.Grid (GridItemArea(..), GridSize(..))
import Hby.Task (Task, runTask_)
import Model.Display.Screen (Screen(..), addItem, mkScreenItem)
import Model.Display.Screen (render) as S
import Model.UI.Counter (Counter(..))
import Model.UI.CounterF (CounterF(..))
import Model.UI.TestButton (TestButton(..))
import Model.UI.TestElement (TestElement(..))

main :: Effect Unit
main = runTask_ $ render { n: 0.0 }
  where
  render :: { n :: Number } -> Task Unit
  render { n } = do
    counter <- pure $ Counter { n, addEvent: \n' -> render { n: n' } }
    counterF <- pure $ CounterF { n, onClick: \n' -> render { n: n' } }
    testButton <- pure $ TestButton unit
    testElement <- pure $ TestElement unit
    S.render
      $ Screen
          { rowSize: [ GridSize_Fr 1, GridSize_Fr 1, GridSize_Fr 1 ]
          , colSize: [ GridSize_Fr 1, GridSize_Fr 1 ]
          , item:
              identity
                $ addItem { area: GridItemArea 0 0 1 1, obj: counter }
                $ addItem { area: GridItemArea 1 0 2 1, obj: counter }
                $ addItem { area: GridItemArea 0 1 1 1, obj: testElement }
                $ addItem { area: GridItemArea 1 1 2 2, obj: counterF }
                $ addItem { area: GridItemArea 0 2 2 3, obj: testButton }
                $ mkScreenItem
          }
