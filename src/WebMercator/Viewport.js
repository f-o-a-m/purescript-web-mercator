"use strict";
var vmp = require("viewport-mercator-project");

exports.unpack = function(vp) {
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

exports.pack = function(viewport) {
  return new vmp.WebMercatorViewport(viewport);
};

exports.project_ = function(vp, lnglat) {
  return vp.project(lnglat);
};

exports.unproject_ = function(vp, pixel) {
  return vp.unproject(pixel);
};
