module Model.Screen where

import Prelude
import Hby.React.Component (HtmlM(..), htmlM, mkHtmlE, setStyle, testElement)
import Hby.React.Dom (render) as D
import Hby.React.Grid (GridItemArea(..), GridSize(..), setGrid, setGridItemArea, setGridSizeCol, setGridSizeRow)
import Hby.Task (Task)
import Model.Counter (Counter)
import Model.CounterF (CounterF)
import Model.TestButton (TestButton)
import Model.View (toHtmlB)

newtype Screen
  = Screen
  { counter :: Counter
  , counterF :: CounterF
  , testButton :: TestButton
  }

render :: Screen -> Task Unit
render (Screen { counter, counterF, testButton }) =
  D.render $ mkHtmlE
    $ setStyle { "height": "100%" }
    $ setGridSizeRow [ GridSize_Fr 1, GridSize_Fr 1, GridSize_Fr 1 ]
    $ setGridSizeCol [ GridSize_Fr 1, GridSize_Fr 1 ]
    $ setGrid
    $ htmlM "div"
        [ Builder $ toHtmlB counter
        , Builder testElement
        , Builder testElement
        , Builder $ toHtmlB counterF
        , Builder $ setGridItemArea (GridItemArea 0 2 2 3) $ toHtmlB testButton
        ]
