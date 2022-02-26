module App.App where

import Prelude
import Component.Component (counter, notFind, add) as C
import Data.Argonaut as A
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Number (fromString)
import Data.Tuple (Tuple(..))
import Event.Event (Event)
import Hby.React.Component (GridItemPlaceItem(..), GridSize(..), HtmlSize(..), grid, mkGrid, setGridColSize, setGridHeight, setGridItemArea, setGridItemPlace, setGridRowSize, testElement)
import Hby.React.Data (HtmlElement)
import Hby.Bom (Location, getQuery)
import State.State (State)

getApp :: State -> Event -> Location -> HtmlElement
getApp s e loc = case loc.hash of
  "" -> main s e
  "#index" -> main s e
  "#add" -> addPage loc
  _ -> notFind

main :: State -> Event -> HtmlElement
main s e =
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

addPage :: Location -> HtmlElement
addPage loc = case A.decodeJson (getQuery loc) of
  Left _ -> page 0.0 0.0
  Right (rx :: { a :: String, b :: String }) -> case getArg rx of
    Nothing -> page 0.0 0.0
    Just a -> page a.a a.b
  where
  getArg :: { a :: String, b :: String } -> Maybe { a :: Number, b :: Number }
  getArg { a, b } = do
    aa <- fromString a
    bb <- fromString b
    pure { a: aa, b: bb }

  page :: Number -> Number -> HtmlElement
  page a b = C.add a b

notFind :: HtmlElement
notFind = C.notFind
