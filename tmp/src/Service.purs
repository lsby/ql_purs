module Service where

import Prelude
import Data.Int (fromNumber)
import Data.Maybe (Maybe(..))
import Data.Number (fromString)
import Effect (Effect)
import Effect.Console (log)
import Hby.Express.Express (appB, listen, middle_cookieParser, middle_json, middle_urlencoded, mkApp, useMiddle, useRoute, useStatic, Route, mkRoute, routeB, setPost, Req, Res, getBody, send)
import Hby.Task (liftEffect, runTask_, throw, Task)
import Node.Globals (__dirname)
import Node.Path (resolve)
import Node.Process (lookupEnv)
import Data.Argonaut (encodeJson, decodeJson) as A
import Data.Either (Either(..))

main :: Effect Unit
main =
  runTask_ do
    staticPath <- liftEffect $ resolve [ __dirname ] "../../dist"
    apiRoute <- api
    app <-
      mkApp
        <<< useMiddle middle_json
        <<< useMiddle middle_urlencoded
        <<< useMiddle middle_cookieParser
        <<< useStatic "/" staticPath
        <<< useRoute "/api" apiRoute
        $ appB
    port <- liftEffect $ lookupEnv "PORT"
    case port >>= fromString >>= fromNumber of
      Nothing -> throw "无法从环境变量获得端口号"
      Just p -> listen app p $ liftEffect $ log $ "start service in http://127.0.0.1:" <> show p

api :: Task Route
api =
  mkRoute
    <<< setPost "/add" onAdd
    $ routeB

onAdd :: Req -> Res -> Task Unit
onAdd req res = do
  case A.decodeJson (getBody req) of
    Left err -> do
      liftEffect $ log $ show err
      send res $ A.encodeJson { err: show err }
    Right (rx :: { a :: Number, b :: Number }) -> do
      liftEffect $ log "收到了请求"
      send res $ A.encodeJson { err: unit, data: rx.a + rx.b }
