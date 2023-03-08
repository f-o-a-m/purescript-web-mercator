"use strict";
import * as VMP from "@math.gl/web-mercator";

export const unpack = function(vp) {
  return {
    width: vp.width,
    height: vp.height,
    latitude: vp.latitude,
    longitude: vp.longitude,
    zoom: vp.zoom,
    pitch: vp.pitch,
    bearing: vp.bearing
  };
};

export const pack = function(viewport) {
  return new VMP.WebMercatorViewport(viewport);
};

export const project_ = function(vp, lnglat) {
  return vp.project(lnglat);
};

export const unproject_ = function(vp, pixel) {
  return vp.unproject(pixel);
};
