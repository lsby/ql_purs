module App.AddPage where

import Prelude
import Component.Component (add) as C
import Data.Argonaut as A
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Number (fromString)
import Hby.Bom (Location, getQuery)
import Hby.React.Component (mkHtmlE)
import Hby.React.Data (HtmlElement)

addPage :: Location -> HtmlElement
addPage loc = case A.decodeJson (getQuery loc) of
  Left _ -> page 0.0 0.0
  Right (rx :: { a :: String, b :: String }) -> case getArg rx of
    Nothing -> page 0.0 0.0
    Just a -> page a.a a.b
  where
  getArg :: { a :: String, b :: String } -> Maybe { a :: Number, b :: Number }
  getArg { a, b } = do
    aa <- fromString a
    bb <- fromString b
    pure { a: aa, b: bb }

  page :: Number -> Number -> HtmlElement
  page a b = mkHtmlE $ C.add { a, b }
