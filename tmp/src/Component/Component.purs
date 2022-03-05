module Component.Component where

import Prelude
import Data.Number.Format (toString)
import Hby.MemoizeOne (memoizeOnce)
import Hby.React.Component (HtmlEBuilder, htmlB, setAttr, text)
import Hby.React.Data (HtmlElement)
import Hby.Task (Task)

--------------------------
counter :: { n :: Number, onClick :: Task Unit } -> HtmlEBuilder
counter { n, onClick } =
  htmlB "div"
    [ text (toString n)
    , setAttr { onClick } $ htmlB "button" [ text "按钮" ]
    ]

--------------------------
add :: { a :: Number, b :: Number } -> HtmlEBuilder
add { a, b } = htmlB "div" [ text $ toString (a + b) ]

--------------------------
foreign import _counterF :: { n :: Number, onClick :: Task Unit } -> HtmlElement

counterF :: { n :: Number, onClick :: Task Unit } -> HtmlElement
counterF = memoizeOnce $ _counterF

--------------------------
