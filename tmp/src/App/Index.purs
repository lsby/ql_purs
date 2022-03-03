module App.Index where

import Prelude
import Component.Component (counter)
import Event.Event (Event)
import Hby.React.Component (htmlE, mkHtmlE, setAttr, setStyle, testElement, text)
import Hby.React.Data (HtmlElement)
import Hby.React.Grid (GridItemArea(..), GridItemPlaceItem(..), GridSize(..), setGrid, setGridItemArea, setGridItemPlaceCol, setGridItemPlaceRow, setGridSizeCol, setGridSizeRow)
import State.State (State)

index :: State -> Event -> HtmlElement
index s e =
  mkHtmlE
    $ setStyle { "height": "100%" }
    $ setGridSizeCol [ (GridSize_Fr 1), (GridSize_Fr 1), (GridSize_Fr 1) ]
    $ setGridSizeRow [ (GridSize_Fr 1), (GridSize_Fr 1), (GridSize_Fr 1) ]
    $ setGrid
    $ htmlE "div"
        [ setGridItemArea (GridItemArea 0 0 1 2)
            $ setGridItemPlaceRow GridItemPlace_Center
            $ setGridItemPlaceCol GridItemPlace_Center
            $ counter s.num e.add
        , testElement
        , testElement
        , setStyle { border: "1px solid", boxSizing: "border-box", width: "100%", height: "100%" }
            $ setGridItemPlaceRow GridItemPlace_Center
            $ setGridItemPlaceCol GridItemPlace_Center
            $ setGrid
            $ htmlE "div"
                [ setGridItemPlaceRow GridItemPlace_Center
                    $ setGridItemPlaceCol GridItemPlace_Center
                    $ setAttr { href: "/add?a=1&b=2#add" }
                    $ htmlE "a" [ text "跳转" ]
                ]
        , testElement
        , setGridItemArea (GridItemArea 0 2 3 3) $ testElement
        ]
