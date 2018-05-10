module WebMercator.Internal where

import Prelude

-- Approximate equality comparison from https://github.com/purescript-contrib/purescript-strongcheck/blob/v3.1.0/src/Test/StrongCheck/Data/ApproxNumber.purs#L12
approximateEqual :: Number -> Number -> Boolean
approximateEqual x y = (y - x) <= epsilon && (y - x) >= (-epsilon)
  where
  epsilon = 0.00000001

