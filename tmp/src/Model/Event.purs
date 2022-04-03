module Model.Event where

import Prelude
import Hby.Task (Task)

data Event
  = Event String (Task Unit)

newtype EventList
  = EventList (Array Event)
