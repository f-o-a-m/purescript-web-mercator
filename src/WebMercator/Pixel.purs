module WebMercator.Pixel where

import Prelude
import Partial.Unsafe (unsafeCrashWith)
import Data.Function (on)
import WebMercator.Internal (approximateEqual)

newtype Pixel = Pixel (Array Number)

derive newtype instance eqPixel :: Eq Pixel
instance showPixel :: Show Pixel where
  show p = "(Pixel.make {x: " <> show (x p) <> ", y: " <> show (y p) <> "})"

approxEqPixel :: Pixel -> Pixel -> Boolean
approxEqPixel a b = on approximateEqual x a b && on approximateEqual y a b

x :: Pixel -> Number
x (Pixel [x', _]) = x'
x (Pixel _) = unsafeCrashWith "Array representing Pixel must contain 2 values"

y :: Pixel -> Number
y (Pixel [_, y']) = y'
y (Pixel _) = unsafeCrashWith "Array representing Pixel must contain 2 values"

make :: { x :: Number, y :: Number } -> Pixel
make p = Pixel [p.x, p.y]
