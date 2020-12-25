/*
  tags: basic

  <p>This example shows how to implement a movable camera with regl.</p>
 */

const regl = require('regl')()

const model = require('bunny')
const normals = require('angle-normals')
const glslify = require('glslify')

const pixels = regl.texture()
const pixels2 = regl.texture()
const pixels3 = regl.texture()

const camera = require('./util/camera')(regl, {
  center: [1.0, 4.0, 0.0]
})

const drawBunny = regl({
  frag: glslify('./shaders/bunny.fs.glsl'),
  vert: glslify('./shaders/bunny.vs.glsl'),
  attributes: {
    position: model.positions,
    normal: normals(model.cells, model.positions)
  },
  uniforms: {
    round: false,
    lightVector: [1.0, 1.0, 0.0],
    texture: pixels,
    t: ({tick}) => 0.005 * tick,
    resolution: (
      {viewportHeight, viewportWidth}
    ) => [viewportWidth, viewportHeight],
  },
  elements: model.cells
})

const drawAberration = regl({
  vert: glslify('./shaders/passthroughVertex.vs.glsl'),
  frag: glslify('./shaders/aberration.fs.glsl'),
  attributes: {
    position: [
      -1.0, -1.5,
      -1.0, 1.0,
      1.0, 1.0,
    ],
  },
  uniforms: {
    z: -0.5,
    texture: pixels,
    t: ({tick}) => 0.005 * tick,
    resolution: (
      {viewportHeight, viewportWidth}
    ) => [viewportWidth, viewportHeight],
  },
  count: 3,
})

const drawFlat = regl({
  vert: glslify('./shaders/passthroughVertex.vs.glsl'),
  frag: glslify('./shaders/lessColor.fs.glsl'),
  attributes: {
    position: [
      -1.0, -2.0,
      -1.0, 1.0,
      1.0, 1.0,
    ],
  },
  uniforms: {
    z: -0.6,
    texture: pixels2,
    resolution: (
      {viewportHeight, viewportWidth}
    ) => [viewportWidth, viewportHeight],
  },
  count: 3,
})
const drawBars = regl({
  vert: glslify('./shaders/passthroughVertex.vs.glsl'),
  frag: glslify('./shaders/bars.fs.glsl'),
  attributes: {
    position: [
      -1.0, -2.5,
      -1.0, 1.0,
      1.0, 1.0,
    ],
  },
  uniforms: {
    z: -0.7,
    t: ({tick}) => 0.005 * tick,
    texture: pixels3,
    resolution: (
      {viewportHeight, viewportWidth}
    ) => [viewportWidth, viewportHeight],
  },
  count: 3,
})

regl.frame(() => {
  regl.clear({
    color: [0, 0, 0, 1]
  })
  camera(() => {
    drawBunny()
  })
  pixels({
    copy: true,
  })
  drawAberration()
  pixels2({
    copy: true
  })
  drawFlat()
  pixels3({
    copy: true
  })
  drawBars()
})