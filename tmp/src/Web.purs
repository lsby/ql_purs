module Web where

import Prelude
import Component.Clock as Clock
import Component.Counter1 as Counter1
import Component.Counter2 as Counter2
import Component.Counter3 as Counter3
import Component.Hello as Hello
import Concur.React.DOM as D
import Concur.React.Run (runWidgetInDom)
import Effect (Effect)

main :: Effect Unit
main =
  runWidgetInDom "app"
    $ D.div'
        [ Hello.main
        , Counter1.main
        , Counter2.main
        , Counter3.main
        , Clock.main
        ]
