module Lens.Lens where

import Data.Lens (Lens', lens')
import Data.Tuple (Tuple(..))

_num :: forall a r. Lens' { num :: a | r } a
_num = lens' \record -> Tuple (record.num) (\n -> record { num = n })
