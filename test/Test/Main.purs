
module Test.Main where


import Prelude

import Effect (Effect)
import Effect.Console (log)
import WebMercator.Viewport (Viewport, ViewportR)
import WebMercator.Viewport as Viewport
import WebMercator.Pixel (Pixel)
import WebMercator.Pixel as Pixel
import WebMercator.LngLat (LngLat)
import WebMercator.LngLat as LngLat
import Test.Assert (assert)

main :: Effect Unit
main = do
  log "project"
  let projected = Viewport.project vp pos
  log $ show $ projected
  assert $ projected `Pixel.approxEq` pixel

  log "unprojected"
  let unprojected = Viewport.unproject vp pixel
  log $ show $ unprojected
  assert $ unprojected `LngLat.approxEq` pos

  log "unViewport"
  assert $ Viewport.unpack vp == vpR

pos :: LngLat
pos = LngLat.make {lng: -122.43, lat: 37.75}

pixel :: Pixel
pixel = Pixel.make { x: 400.0, y : 300.0 }

vpR :: Record (ViewportR ())
vpR =
  { latitude: 37.75
  , longitude: -122.43
  , zoom: 10.0
  , pitch: 0.0
  , bearing: 0.0
  , width: 800.0
  , height: 600.0
  }

vp :: Viewport
vp = Viewport.pack vpR
