module App.Index where

import Prelude
import Component.Component (counter) as C
import Data.Tuple (Tuple(..))
import Event.Event (Event)
import Hby.React.Component (GridItemPlaceItem(..), GridSize(..), HtmlSize(..), grid, mkGrid, setGridColSize, setGridHeight, setGridItemArea, setGridItemPlace, setGridRowSize, testElement)
import Hby.React.Data (HtmlElement)
import State.State (State)

index :: State -> Event -> HtmlElement
index s e =
  mkGrid
    $ setGridHeight (H_Scale 100.0)
    $ setGridRowSize [ (S_Fr 1), (S_Fr 1), (S_Fr 1) ]
    $ setGridColSize [ (S_Fr 1), (S_Fr 1), (S_Fr 1) ]
    $ grid
        [ setGridItemArea (Tuple 0 0) (Tuple 1 2) $ setGridItemPlace I_Center I_Center (C.counter s.num e.add)
        , testElement
        , testElement
        , testElement
        , testElement
        , setGridItemArea (Tuple 0 2) (Tuple 3 3) testElement
        ]
