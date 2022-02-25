module Event.Event where

import Prelude
import Data.Lens (over)
import Effect.Ref (Ref)
import Effect.Ref as Ref
import Hby.Task (Task, liftEffect)
import Lens.Lens (_num)
import State.State (State)

--------------------------
type Event
  = { add :: Task Unit
    }

--------------------------
getEvent :: Ref State -> Task Unit -> Event
getEvent sRef reRender = do
  { add: add' sRef reRender
  }

--------------------------
add' :: Ref State -> Task Unit -> Task Unit
add' sRef reRender = do
  liftEffect $ Ref.modify_ (over _num ((+) 1.0)) sRef
  reRender
