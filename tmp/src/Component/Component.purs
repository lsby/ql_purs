module Component.Component where

import Prelude
import Data.Number.Format (toString)
import Hby.React.Component (HtmlEBuilder, htmlE, setAttr, text)
import Hby.Task (Task)

--------------------------
counter :: Number -> (Task Unit) -> HtmlEBuilder
counter n e =
  htmlE "div"
    [ text (toString n)
    , setAttr { onClick: e } $ htmlE "button" [ text "按钮" ]
    ]

--------------------------
add :: Number -> Number -> HtmlEBuilder
add a b = htmlE "div" [ text $ toString (a + b) ]

--------------------------
