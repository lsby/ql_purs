module Process.Process where

import Prelude
import Data.Argonaut (Json)
import Data.Argonaut (encodeJson, decodeJson) as A
import Data.Either (Either(..))
import Effect.Console (log)
import Hby.Electron.Data (IpcMainEvent)
import Hby.Electron.IpcMainEvent (reply, setReturnValue)
import Hby.Task (Task, liftEffect)

onSync :: IpcMainEvent → Json → Task Unit
onSync e a = do
  case A.decodeJson a of
    Left err -> liftEffect $ log $ show err
    Right (rx :: { msg :: String }) -> do
      liftEffect $ log $ show rx
      setReturnValue e $ A.encodeJson { msg: "testSync-toWeb" }

onAsync :: IpcMainEvent → Json → Task Unit
onAsync e a = do
  case A.decodeJson a of
    Left err -> liftEffect $ log $ show err
    Right (rx :: { msg :: String }) -> do
      liftEffect $ log $ show rx
      reply e "testAsync-reply" $ A.encodeJson { msg: "testSync-toWeb" }
