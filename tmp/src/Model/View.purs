module Model.View where

import Hby.React.Component (HtmlEBuilder)

class View a where
  toHtmlB :: a -> HtmlEBuilder
