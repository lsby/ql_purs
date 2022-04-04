module Model.Display.View where

import Hby.React.Data (HtmlElement)

class View a where
  toHtmlElement :: a -> HtmlElement
