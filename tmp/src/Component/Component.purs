module Component.Component where

import Prelude
import Hby.MemoizeOne (memoizeOnce)
import Hby.React.Data (HtmlElement)
import Hby.Task (Task)

--------------------------
foreign import _counter :: Number -> Task Unit -> HtmlElement

counter :: Number -> Task Unit -> HtmlElement
counter = memoizeOnce $ _counter

--------------------------
foreign import _add :: Number -> Number -> HtmlElement

add :: Number -> Number -> HtmlElement
add = memoizeOnce $ _add

--------------------------
