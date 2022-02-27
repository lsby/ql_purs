module App.Index where

import Prelude
import Component.Component (counter) as C
import Data.Argonaut as A
import Data.Tuple (Tuple(..))
import Event.Event (Event)
import Hby.React.Component (GridItemPlaceItem(..), GridSize(..), HtmlSize(..), grid, htmlE, mkGrid, mkHtmlE, setGridColSize, setGridHeight, setGridItemArea, setGridItemPlace, setGridRowSize, setHtmlEAttr, testElement, text)
import Hby.React.Data (HtmlElement)
import State.State (State)

index :: State -> Event -> HtmlElement
index s e =
  mkGrid
    $ setGridHeight (H_Scale 100.0)
    $ setGridRowSize [ (S_Fr 1), (S_Fr 1), (S_Fr 1) ]
    $ setGridColSize [ (S_Fr 1), (S_Fr 1), (S_Fr 1) ]
    $ grid
        [ setGridItemArea (Tuple 0 0) (Tuple 1 2) $ setGridItemPlace I_Center I_Center (A.encodeJson {}) (C.counter s.num e.add)
        , testElement
        , testElement
        , setGridItemPlace I_Center I_Center (A.encodeJson { border: "1px solid", boxSizing: "border-box", width: "100%", height: "100%" })
            $ mkGrid
            $ grid
                [ setGridItemPlace I_Center I_Center (A.encodeJson {})
                    $ mkHtmlE
                    $ setHtmlEAttr (A.encodeJson { href: "/add?a=1&b=2#add" })
                    $ htmlE "a" [ text "跳转" ]
                ]
        , testElement
        , setGridItemArea (Tuple 0 2) (Tuple 3 3) testElement
        ]
