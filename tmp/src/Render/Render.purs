module Render.Render where

import Prelude
import App.App (getApp)
import Effect.Ref (Ref)
import Effect.Ref (read) as Ref
import Event.Event (Event, getEvent)
import Hby.MemoizeOne (memoizeOnce)
import Hby.React.Data (HtmlElement)
import Hby.React.Dom (render)
import Hby.Task (Task, liftEffect)
import Hby.Bom (Location, getLocation)
import State.State (State)

getApp' :: State → Event → Location -> HtmlElement
getApp' s e location = memoizeOnce $ getApp s e location

computeApp :: Ref State -> Location -> Task HtmlElement
computeApp sRef location = do
  s <- liftEffect $ Ref.read sRef
  e <- pure $ getEvent sRef (reRender sRef)
  pure $ getApp' s e location

renderBeforeEffect :: Ref State -> Location -> Task Unit
renderBeforeEffect _ _ = do
  pure unit

renderAfterEffect :: Ref State -> Location -> Task Unit
renderAfterEffect _ _ = do
  pure unit

reRender :: Ref State -> Task Unit
reRender sRef = do
  location <- getLocation
  app <- computeApp sRef location
  renderBeforeEffect sRef location
  render app
  renderAfterEffect sRef location
