module Model.Demo.TestButton where

import Prelude
import Data.Argonaut as A
import Data.Either (Either(..))
import Hby.Electron.IPCRenderer (sendSync)
import Hby.React.Component (htmlB, mkHtmlE, setAttr, setStyle, text)
import Hby.React.Grid (setGrid)
import Hby.Task (Task, log)
import Hby.Unsafe (unsafeLog)
import Model.Display.View (class View)

newtype TestButton
  = TestButton Unit

instance name :: View TestButton where
  toHtmlElement _ =
    mkHtmlE
      $ setGrid
      $ setStyle { border: 1, borderStyle: "solid", height: "100%", boxSizing: "border-box" }
      $ htmlB "div"
          [ setAttr { onClick: sendToElectron } $ htmlB "button" [ text "测试同步事件" ]
          ]
    where
    sendToElectron :: Task Unit
    sendToElectron = do
      r <- sendSync "testSync" $ A.encodeJson { msg: "testSync-toMain" }
      case A.decodeJson r of
        Left err -> do
          log $ show err
          unsafeLog r
        Right (rx :: { msg :: String }) -> do
          log $ show rx.msg
