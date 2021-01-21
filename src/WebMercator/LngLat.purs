module WebMercator.LngLat
  ( LngLat
  , lng
  , lat
  , make
  , approxEq
  ) where


import Prelude
import Partial.Unsafe (unsafeCrashWith)
import Data.Function (on)
import WebMercator.Internal (approximateEqual)

newtype LngLat = LngLat (Array Number)

derive newtype instance eqLngLat :: Eq LngLat
derive newtype instance ordLngLat :: Ord LngLat
instance showLngLat :: Show LngLat where
  show p = "(LngLat.make {lng: " <> show (lng p) <> ", lat: " <> show (lat p) <> "})"

approxEq :: LngLat -> LngLat -> Boolean
approxEq a b = on approximateEqual lng a b && on approximateEqual lat a b

lng :: LngLat -> Number
lng (LngLat [lng', _]) = lng'
lng (LngLat _) = unsafeCrashWith "Array representing LngLat must contain 2 values"

lat :: LngLat -> Number
lat (LngLat [_, lat']) = lat'
lat (LngLat _) = unsafeCrashWith "Array representing LngLat must contain 2 values"

make :: forall r. { lng :: Number, lat :: Number | r } -> LngLat
make p = LngLat [p.lng, p.lat]
