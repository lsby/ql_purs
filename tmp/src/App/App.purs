module App.App where

import Prelude
import Component.Component (counter)
import Data.Tuple (Tuple(..))
import Event.Event (Event)
import Hby.React.Component (GridItemPlaceItem(..), GridSize(..), HtmlSize(..), grid, mkGrid, setGridColSize, setGridHeight, setGridItemArea, setGridItemPlace, setGridRowSize, testElement)
import Hby.React.Data (HtmlElement)
import State.State (State)

getApp :: State -> Event -> HtmlElement
getApp s e =
  mkGrid
    $ setGridHeight (H_Scale 100.0)
    $ setGridRowSize [ (S_Fr 1), (S_Fr 1), (S_Fr 1) ]
    $ setGridColSize [ (S_Fr 1), (S_Fr 1), (S_Fr 1) ]
    $ grid
        [ testElement
        , setGridItemArea (Tuple 0 0) (Tuple 1 2) $ setGridItemPlace I_Center I_Center (counter s.num e.add)
        , testElement
        , testElement
        , testElement
        , setGridItemArea (Tuple 0 2) (Tuple 3 3) testElement
        ]
