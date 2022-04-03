module Model.Screen
  ( mkScreenNilItem
  , addItem
  , render
  , Screen(..)
  , ScreenItemList_Cons
  , ScreenItemList_Nil
  , class AddItem
  , class ToHtmlArray
  , toHtmlArray
  ) where

import Prelude
import Hby.React.Component (HtmlEBuilder, htmlB, mkHtmlE, setStyle)
import Hby.React.Dom (render) as D
import Hby.React.Grid (GridItemArea, GridSize, setGrid, setGridItemArea, setGridSizeCol, setGridSizeRow)
import Hby.Task (Task)
import Model.View (class View, toHtmlB)

newtype Screen a b
  = Screen
  { rowSize :: Array GridSize
  , colSize :: Array GridSize
  , item :: ScreenItemList_Cons a b
  }

type ScreenItem a
  = { area :: GridItemArea, obj :: a }

data ScreenItemList_Cons a b
  = Cons (ScreenItem a) b

data ScreenItemList_Nil
  = Nil

mkScreenNilItem :: ScreenItemList_Nil
mkScreenNilItem = Nil

class AddItem a where
  addItem :: forall c. View c => ScreenItem c -> a -> ScreenItemList_Cons c a

instance _AddItem_ScreenItemList_Cons :: AddItem (ScreenItemList_Cons d e) where
  addItem :: forall c. View c => ScreenItem c -> (ScreenItemList_Cons d e) -> ScreenItemList_Cons c (ScreenItemList_Cons d e)
  addItem c a = Cons c a

instance _AddItem_ScreenItemList_Nil :: AddItem ScreenItemList_Nil where
  addItem c _ = Cons c Nil

class ToHtmlArray a where
  toHtmlArray :: a -> Array HtmlEBuilder

instance _ToHtmlArray_ScreenItemList_Cons :: (View a, ToHtmlArray b) => ToHtmlArray (ScreenItemList_Cons a b) where
  toHtmlArray o = case o of
    Cons ({ area, obj }) b -> [ setGridItemArea area $ toHtmlB obj ] <> toHtmlArray b

instance _ToHtmlArray_ScreenItemList_Nil :: ToHtmlArray ScreenItemList_Nil where
  toHtmlArray _ = []

render :: forall a b. ToHtmlArray (ScreenItemList_Cons a b) => View a => Screen a b -> Task Unit
render (Screen { rowSize, colSize, item }) =
  D.render $ mkHtmlE
    $ setStyle { "height": "100%" }
    $ setGridSizeRow rowSize
    $ setGridSizeCol colSize
    $ setGrid
    $ htmlB "div"
    $ toHtmlArray item
