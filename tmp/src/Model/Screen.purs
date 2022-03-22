module Model.Screen where

import Prelude
import Component.Component (counterF)
import Hby.React.Component (HtmlM(..), htmlM, mkHtmlE, setStyle, testElement)
import Hby.React.Dom (render) as D
import Hby.React.Grid (GridSize(..), setGrid, setGridSizeCol, setGridSizeRow)
import Hby.Task (Task)
import Model.Counter (Counter(..), mkHtml)

newtype Screen
  = Screen { n :: Number }

render :: Screen -> Task Unit
render (Screen { n }) =
  D.render $ mkHtmlE
    $ setStyle { "height": "100%" }
    $ setGridSizeRow [ GridSize_Fr 1, GridSize_Fr 1 ]
    $ setGridSizeCol [ GridSize_Fr 1, GridSize_Fr 1 ]
    $ setGrid
    $ htmlM "div" [ Builder $ mkHtml $ Counter { n, addEvent }, Builder testElement, Builder testElement, Element $ counterF { n, onClick: addEvent } ]
  where
  addEvent :: Number -> Task Unit
  addEvent n' = do
    s <- pure $ Screen { n: n' }
    render s
