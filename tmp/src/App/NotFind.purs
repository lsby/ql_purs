module App.NotFind where

import Prelude
import Hby.React.Component (htmlB, mkHtmlE, text)
import Hby.React.Data (HtmlElement)

notFind :: HtmlElement
notFind = mkHtmlE $ htmlB "p" [ text "页面没有找到" ]
