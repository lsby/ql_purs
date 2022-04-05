module Model.Demo.Main where

import Prelude
import Hby.React.Grid (GridItemArea(..), GridSize(..))
import Hby.Task (Task)
import Model.Demo.Counter (Counter(..))
import Model.Demo.CounterF (CounterF(..))
import Model.Demo.TestButton (TestButton(..))
import Model.Demo.TestElement (TestElement(..))
import Model.Display.Screen (Screen(..), addItem, mkScreenItem)
import Model.Display.Screen (render) as S

newtype Demo
  = Demo { n :: Number }

mkDemo :: Demo
mkDemo = Demo { n: 0.0 }

render :: Demo -> Task Unit
render (Demo { n }) = do
  item <-
    pure $ identity
      $ addItem { area: GridItemArea 0 0 1 1, obj: Counter { n, addEvent: render <<< onAdd } }
      $ addItem { area: GridItemArea 1 0 2 1, obj: Counter { n, addEvent: render <<< onAdd } }
      $ addItem { area: GridItemArea 0 1 1 1, obj: TestElement unit }
      $ addItem { area: GridItemArea 1 1 2 2, obj: CounterF { n, onClick: render <<< onAdd } }
      $ addItem { area: GridItemArea 0 2 2 3, obj: TestButton unit }
      $ mkScreenItem
  S.render
    $ Screen
        { rowSize: [ GridSize_Fr 1, GridSize_Fr 1, GridSize_Fr 1 ]
        , colSize: [ GridSize_Fr 1, GridSize_Fr 1 ]
        , item: item
        }

onAdd :: Number -> Demo
onAdd n = Demo { n }
