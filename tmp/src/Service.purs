module Service where

import Prelude
import Data.Int (fromNumber)
import Data.Maybe (Maybe(..))
import Data.Number (fromString)
import Effect (Effect)
import Effect.Console (log)
import Hby.Express.Express (appB, listen, middle_cookieParser, middle_json, middle_urlencoded, mkApp, useMiddle, useRoute, useStatic)
import Hby.Task (liftEffect, runTask_, throw)
import Interface.Interface (api)
import Node.Globals (__dirname)
import Node.Path (resolve)
import Node.Process (lookupEnv)

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
