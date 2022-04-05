module Model.Demo.CounterF where

import Prelude
import Component.Component (counterF)
import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Hby.Task (Task)
import Model.Display.View (class View)
import Type.Proxy (Proxy(..))

newtype CounterF
  = CounterF { n :: Number, onClick :: Number -> Task Unit }

_n :: forall a r. Lens' { n :: a | r } a
_n = prop (Proxy :: Proxy "n")

instance viewCounterF :: View CounterF where
  toHtmlElement (CounterF { n, onClick: e }) = counterF { n, onClick: \n' -> e n' }
