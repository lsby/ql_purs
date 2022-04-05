module Model.Demo.TestElement where

import Prelude
import Hby.React.Component (mkHtmlE, testElement)
import Model.Display.View (class View)

newtype TestElement
  = TestElement Unit

instance name :: View TestElement where
  toHtmlElement _ = mkHtmlE testElement
