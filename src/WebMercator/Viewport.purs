module WebMercator.Viewport
  ( Viewport
  , ViewportR
  , pack
  , unpack
  , project
  , project_
  , unproject
  , unproject_
  , BoundingBox
  , boundingBox
  , isInBoundingBox
  ) where

import Prelude

import Data.Function.Uncurried (runFn2, Fn2)
import WebMercator.Pixel (Pixel)
import WebMercator.Pixel as Pixel
import WebMercator.LngLat (LngLat)
import WebMercator.LngLat as LngLat

foreign import data Viewport :: Type

type ViewportR r =
  ( width :: Number
  , height :: Number
  , latitude :: Number
  , longitude :: Number
  , zoom :: Number
  , pitch :: Number
  , bearing :: Number
  | r )

foreign import pack :: forall r. Record (ViewportR r) -> Viewport
foreign import unpack :: Viewport -> Record (ViewportR ())


project :: Viewport -> LngLat -> Pixel
project = runFn2 project_

foreign import project_ :: Fn2 Viewport LngLat Pixel

unproject :: Viewport -> Pixel -> LngLat
unproject = runFn2 unproject_

foreign import unproject_ :: Fn2 Viewport Pixel LngLat


type BoundingBox = { sw :: LngLat, ne :: LngLat }

boundingBox :: Viewport -> BoundingBox
boundingBox vp =
  let
    { height, width } = unpack vp
  in
    { sw: unproject vp $ Pixel.make {x: 0.0, y: height}
    , ne: unproject vp $ Pixel.make {x: width, y: 0.0}
    }

isInBoundingBox :: BoundingBox -> LngLat -> Boolean
isInBoundingBox box p
   = LngLat.lng p <= LngLat.lng box.ne
  && LngLat.lng p >= LngLat.lng box.sw
  && LngLat.lat p <= LngLat.lat box.ne
  && LngLat.lat p >= LngLat.lat box.sw
