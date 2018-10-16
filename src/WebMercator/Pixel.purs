module WebMercator.Pixel
  ( Pixel
  , x
  , y
  , make
  , approxEq
  ) where

import Prelude
import Partial.Unsafe (unsafeCrashWith)
import Data.Function (on)
import WebMercator.Internal (approximateEqual)

newtype Pixel = Pixel (Array Number)

derive newtype instance eqPixel :: Eq Pixel
derive newtype instance ordPixel :: Ord Pixel
instance showPixel :: Show Pixel where
  show p = "(Pixel.make {x: " <> show (x p) <> ", y: " <> show (y p) <> "})"

approxEq :: Pixel -> Pixel -> Boolean
approxEq a b = on approximateEqual x a b && on approximateEqual y a b

x :: Pixel -> Number
x (Pixel [x', _]) = x'
x (Pixel _) = unsafeCrashWith "Array representing Pixel must contain 2 values"

y :: Pixel -> Number
y (Pixel [_, y']) = y'
y (Pixel _) = unsafeCrashWith "Array representing Pixel must contain 2 values"

make :: { x :: Number, y :: Number } -> Pixel
make p = Pixel [p.x, p.y]
