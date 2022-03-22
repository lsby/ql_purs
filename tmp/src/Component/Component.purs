module Component.Component where

import Prelude
import Hby.MemoizeOne (memoizeOnce)
import Hby.React.Data (HtmlElement)
import Hby.Task (Task)
import Data.Lens (Lens', lens')
import Data.Tuple (Tuple(..))

--------------------------
foreign import _counterF :: { n :: Number, onClick :: Number -> Task Unit } -> HtmlElement

counterF :: { n :: Number, onClick :: Number -> Task Unit } -> HtmlElement
counterF = memoizeOnce $ _counterF

_n :: forall a r. Lens' { n :: a | r } a
_n = lens' \record -> Tuple (record.n) (\n' -> record { n = n' })

--------------------------
