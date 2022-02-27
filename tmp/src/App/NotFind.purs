module App.NotFind where

import Prelude
import Hby.React.Component (htmlE, mkHtmlE, text)
import Hby.React.Data (HtmlElement)

notFind :: HtmlElement
notFind = mkHtmlE $ htmlE "p" [ text "页面没有找到" ]
