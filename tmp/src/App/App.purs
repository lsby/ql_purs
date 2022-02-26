module App.App where

import App.AddPage (addPage)
import App.Index (index)
import App.NotFind (notFind)
import Event.Event (Event)
import Hby.Bom (Location)
import Hby.React.Data (HtmlElement)
import State.State (State)

getApp :: State -> Event -> Location -> HtmlElement
getApp s e loc = case loc.hash of
  "" -> index s e
  "#index" -> index s e
  "#add" -> addPage loc
  _ -> notFind
