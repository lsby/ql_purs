module Web where

import Prelude
import Component.FFI.Button (button)
import Concur.React.DOM as D
import Concur.React.Props as P
import Concur.React.Run (runWidgetInDom)
import Control.Alt ((<|>))
import Effect (Effect)

main :: Effect Unit
main = runWidgetInDom "app" $ f 0
  where
  f n = do
    _ <- D.text (show n) <|> (button [ P.onClick ] [ D.text "按钮" ])
    f $ n + 1
