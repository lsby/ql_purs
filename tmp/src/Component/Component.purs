module Component.Component where

import Prelude
import Hby.MemoizeOne (memoizeOnce)
import Hby.React.Data (HtmlElement)
import Hby.Task (Task)

--------------------------
foreign import _counterF :: { n :: Number, onClick :: Number -> Task Unit } -> HtmlElement

counterF :: { n :: Number, onClick :: Number -> Task Unit } -> HtmlElement
counterF = memoizeOnce $ _counterF

--------------------------
