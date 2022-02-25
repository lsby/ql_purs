module Electron where

import Prelude
import Data.Array (length)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Console (log)
import Hby.Electron.App (onActivate, onWindowAllClosed, quit, whenReady)
import Hby.Electron.BrowserWindow (getAllWindows, getWebContents, loadFile, loadURL, newBrowserWindow)
import Hby.Electron.Data (BrowserWindowConf)
import Hby.Electron.IPCMain (on)
import Hby.Electron.WebContents (openDevTools)
import Hby.Task (Task, liftEffect, runTask_)
import Node.Globals (__dirname)
import Node.Path (resolve)
import Node.Platform (toString)
import Node.Process (lookupEnv, platform)
import Process.Process (onAsync, onSync)

main :: Effect Unit
main =
  runTask_ do
    whenReady
    createWindow
    onActivate onAllCloseCreate
    onWindowAllClosed setDarwinPlatform
    setIPCEvent
  where
  bwConf :: Task BrowserWindowConf
  bwConf = do
    p <- liftEffect $ resolve [ __dirname ] "../../dist/preload.js"
    pure
      { width: 800.0
      , height: 600.0
      , resizable: false
      , webPreferences:
          { contextIsolation: false
          , preload: p
          }
      }

  createWindow :: Task Unit
  createWindow = do
    conf <- bwConf
    bw <- newBrowserWindow conf
    wc <- pure $ getWebContents bw
    env <- liftEffect $ lookupEnv "NODE_ENV"
    pure unit
    case env of
      Just "development" -> do
        liftEffect $ log "开发模式启动"
        loadURL bw "http://localhost:1234"
      _ -> do
        liftEffect $ log "生产模式启动"
        p <- liftEffect $ resolve [ __dirname ] "../../dist/index.html"
        loadFile bw p
    openDevTools wc

  setDarwinPlatform :: Task Unit
  setDarwinPlatform = case platform of
    Nothing -> pure unit
    Just p -> case toString p of
      "darwin" -> pure unit
      _ -> quit

  onAllCloseCreate :: Task Unit
  onAllCloseCreate = do
    arr <- getAllWindows
    case length arr of
      0 -> createWindow
      _ -> pure unit

  setIPCEvent :: Task Unit
  setIPCEvent = do
    on "testSync" onSync
    on "testAsync" onAsync
