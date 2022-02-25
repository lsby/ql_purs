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
import State.State (State)

getApp' :: State → Event → HtmlElement
getApp' = memoizeOnce getApp

computeApp :: Ref State -> Task HtmlElement
computeApp sRef = do
  s <- liftEffect $ Ref.read sRef
  e <- pure $ getEvent sRef (reRender sRef)
  pure $ getApp' s e

renderBeforeEffect :: Ref State -> Task Unit
renderBeforeEffect _ = do
  pure unit

renderAfterEffect :: Ref State -> Task Unit
renderAfterEffect _ = do
  pure unit

reRender :: Ref State -> Task Unit
reRender sRef = do
  app <- computeApp sRef
  renderBeforeEffect sRef
  render app
  renderAfterEffect sRef
