module Service where

import Prelude
import Data.Int (fromNumber)
import Data.Maybe (Maybe(..))
import Data.Number (fromString)
import Effect (Effect)
import Effect.Console (log)
import Hby.Express.Express (listen, middle_cookieParser, middle_json, middle_urlencoded, mkApp, mkRoute, setPost, useMiddle, useRoute, useStatic)
import Hby.Task (liftEffect, runTask_, throw)
import Interface.Interface (onAdd)
import Node.Process (lookupEnv)

main :: Effect Unit
main =
  runTask_ do
    app <- mkApp
    route <- mkRoute
    useMiddle app middle_json
    useMiddle app middle_urlencoded
    useMiddle app middle_cookieParser
    useStatic app "/" "dist"
    setPost route "/add" onAdd
    useRoute app "/api" route
    port <- liftEffect $ lookupEnv "PORT"
    case port >>= fromString >>= fromNumber of
      Nothing -> throw "无法从环境变量获得端口号"
      Just p -> listen app p $ liftEffect $ log $ "start service in http://127.0.0.1:" <> show p
