module Component.Clock where

import Prelude
import Concur.Core (Widget)
import Concur.Core.FRP (Signal, dyn, loopS, loopW)
import Concur.React (HTML)
import Concur.React.DOM as D
import Effect.Aff (Milliseconds(..), delay)
import Effect.Aff.Class (liftAff)

main :: forall a. Widget HTML a
main = do
  dyn
    $ loopS 0 \n -> do
        n' <- incrementTicker n
        counterSignal n'

counterSignal :: Int -> Signal HTML Int
counterSignal init =
  loopW init
    $ \n ->
        D.div'
          [ D.div' [ D.text (show n) ]
          ]

incrementTicker :: Int -> Signal HTML Int
incrementTicker init =
  loopW init
    $ \n -> do
        liftAff $ delay $ Milliseconds 1000.0
        pure (n + 1)
