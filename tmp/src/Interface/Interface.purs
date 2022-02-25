module Interface.Interface where

import Prelude
import Data.Argonaut (encodeJson, decodeJson) as A
import Data.Either (Either(..))
import Effect.Console (log)
import Hby.Task (Task, liftEffect)
import Hby.Express.Express (Req, Res, getBody, send)

onAdd :: Req -> Res -> Task Unit
onAdd req res = do
  case A.decodeJson (getBody req) of
    Left err -> do
      liftEffect $ log $ show err
      send res $ A.encodeJson { err: show err }
    Right (rx :: { a :: Number, b :: Number }) -> do
      liftEffect $ log "收到了请求"
      send res $ A.encodeJson { err: unit, data: rx.a + rx.b }
