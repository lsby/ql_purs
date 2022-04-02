module Model.Counter where

import Prelude
import Data.Lens (Lens', lens')
import Data.Number.Format (toString)
import Data.Tuple (Tuple(..))
import Hby.React.Component (htmlB, setAttr, setStyle, text)
import Hby.Task (Task)
import Model.View (class View)

newtype Counter
  = Counter { n :: Number, addEvent :: Number -> Task Unit }

_n :: forall a r. Lens' { n :: a | r } a
_n = lens' \record -> Tuple (record.n) (\n' -> record { n = n' })

instance viewCounter :: View Counter where
  toHtmlB (Counter { n, addEvent }) =
    setStyle { border: 1, borderStyle: "solid", height: "100%", boxSizing: "border-box" }
      $ htmlB "div"
          [ text (toString n)
          , setAttr { onClick } $ htmlB "button" [ text "按钮" ]
          ]
    where
    onClick = addEvent $ n + 1.0
