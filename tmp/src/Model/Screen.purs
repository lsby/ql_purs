module Model.Screen where

import Prelude
import Component.Component (counterF)
import Data.Argonaut (encodeJson, decodeJson) as A
import Data.Either (Either(..))
import Hby.Electron.IPCRenderer (sendSync)
import Hby.React.Component (HtmlM(..), htmlB, htmlM, mkHtmlE, setAttr, setStyle, testElement, text)
import Hby.React.Dom (render) as D
import Hby.React.Grid (GridItemArea(..), GridSize(..), setGrid, setGridItemArea, setGridSizeCol, setGridSizeRow)
import Hby.Task (Task, liftEffect, log)
import Hby.Unsafe (unsafeLog)
import Model.Counter (Counter(..), toHtmlB)

newtype Screen
  = Screen { n :: Number }

render :: Screen -> Task Unit
render (Screen { n }) =
  D.render $ mkHtmlE
    $ setStyle { "height": "100%" }
    $ setGridSizeRow [ GridSize_Fr 1, GridSize_Fr 1, GridSize_Fr 1 ]
    $ setGridSizeCol [ GridSize_Fr 1, GridSize_Fr 1 ]
    $ setGrid
    $ htmlM "div"
        [ Builder $ toHtmlB $ Counter { n, addEvent }
        , Builder testElement
        , Builder testElement
        , Element $ counterF { n, onClick: addEvent }
        , Builder $ setGridItemArea (GridItemArea 0 2 2 3) $ setAttr { onClick: sendToElectron } $ htmlB "button" [ text "按钮" ]
        ]
  where
  addEvent :: Number -> Task Unit
  addEvent n' = do
    s <- pure $ Screen { n: n' }
    render s

  sendToElectron :: Task Unit
  sendToElectron = do
    r <- sendSync "testSync" $ A.encodeJson { msg: "testSync-toMain" }
    case A.decodeJson r of
      Left err -> do
        log $ show err
        unsafeLog r
      Right (rx :: { msg :: String }) -> do
        log $ show rx.msg
