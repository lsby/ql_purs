module Web where

import Prelude
import Component.Component (counterF)
import Data.Argonaut as A
import Data.Either (Either(..))
import Data.Number.Format (toString)
import Effect (Effect)
import Hby.Electron.IPCRenderer (sendSync)
import Hby.React.Component (HtmlEBuilder, htmlB, htmlE, mkHtmlE, setAttr, setStyle, testElement, text)
import Hby.React.Dom (render) as D
import Hby.React.Grid (GridItemArea(..), GridSize(..), setGrid, setGridItemArea, setGridSizeCol, setGridSizeRow)
import Hby.Task (Task, runTask_)
import Hby.Task as T
import Hby.Unsafe (unsafeLog)

main :: Effect Unit
main = runTask_ $ render { n: 0.0 }
  where
  render :: { n :: Number } -> Task Unit
  render { n } = do
    D.render
      $ mkHtmlE
      $ setStyle { "height": "100%" }
      $ setGridSizeRow [ GridSize_Fr 1, GridSize_Fr 1, GridSize_Fr 1 ]
      $ setGridSizeCol [ GridSize_Fr 1, GridSize_Fr 1 ]
      $ setGrid
      $ htmlB "div"
          [ counter n
          , counter n
          , testElement
          , htmlE "div" [ counterF { n, onClick: onClick } ]
          , setGridItemArea (GridItemArea 0 2 2 3)
              $ setGrid
              $ setStyle { border: 1, borderStyle: "solid", height: "100%", boxSizing: "border-box" }
              $ htmlB "div"
                  [ setAttr { onClick: sendToElectron } $ htmlB "button" [ text "测试同步事件" ]
                  ]
          ]

  counter :: Number -> HtmlEBuilder
  counter n =
    setStyle { border: 1, borderStyle: "solid", height: "100%", boxSizing: "border-box" }
      $ htmlB "div"
          [ text (toString n)
          , setAttr { onClick: onClick (n + 1.0) } $ htmlB "button" [ text "按钮" ]
          ]

  onClick :: Number -> Task Unit
  onClick n = do
    T.lazy render $ { n: n }

  sendToElectron :: Task Unit
  sendToElectron = do
    r <- sendSync "testSync" $ A.encodeJson { msg: "testSync-toMain" }
    case A.decodeJson r of
      Left err -> do
        T.log $ show err
        unsafeLog r
      Right (rx :: { msg :: String }) -> do
        T.log $ show rx.msg
