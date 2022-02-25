module Web where

import Prelude
import Effect (Effect)
import Effect.Ref (new) as Ref
import Hby.Dom.Event (onDOMContentLoaded, onResize)
import Hby.Task (liftEffect, runTask_)
import Render.Render (reRender)
import State.State (initState)

main :: Effect Unit
main =
  runTask_ do
    sRef <- liftEffect $ Ref.new initState
    onResize $ reRender sRef
    onDOMContentLoaded $ reRender sRef
