module Model.CounterF where

import Prelude
import Component.Component (counterF)
import Data.Lens (Lens', lens')
import Data.Tuple (Tuple(..))
import Hby.React.Component (htmlE)
import Hby.Task (Task)
import Model.View (class View)

newtype CounterF
  = CounterF { n :: Number, onClick :: Number -> Task Unit }

_n :: forall a r. Lens' { n :: a | r } a
_n = lens' \record -> Tuple (record.n) (\n' -> record { n = n' })

instance viewCounterF :: View CounterF where
  toHtmlB (CounterF { n, onClick: e }) = htmlE "div" [ counterF { n, onClick: \n' -> e n' } ]
