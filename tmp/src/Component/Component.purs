module Component.Component where

import Prelude
import Data.Number.Format (toString)
import Hby.React.Component (HtmlEBuilder, htmlE, setAttr, text)
import Hby.Task (Task)

--------------------------
counter :: { n :: Number, onClick :: Task Unit } -> HtmlEBuilder
counter { n, onClick } =
  htmlE "div"
    [ text (toString n)
    , setAttr { onClick } $ htmlE "button" [ text "按钮" ]
    ]

--------------------------
add :: { a :: Number, b :: Number } -> HtmlEBuilder
add { a, b } = htmlE "div" [ text $ toString (a + b) ]

--------------------------
