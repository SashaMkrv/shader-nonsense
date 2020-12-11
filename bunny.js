/*
  tags: basic

  <p>This example shows how to implement a movable camera with regl.</p>
 */

const regl = require('regl')()

const bunny = require('bunny')
const normals = require('angle-normals')
const glslify = require('glslify')

const camera = require('./util/camera')(regl, {
  center: [0, 2.5, 0]
})

const drawBunny = regl({
  frag: glslify('./shaders/bunny.fs.glsl'),
  vert: glslify('./shaders/bunny.vs.glsl'),
  attributes: {
    position: bunny.positions,
    normal: normals(bunny.cells, bunny.positions)
  },
  uniforms: {
    t: ({tick}) => 0.005 * tick,
    resolution: (
      {viewportHeight, viewportWidth}
    ) => [viewportWidth, viewportHeight],
  },
  elements: bunny.cells
})

regl.frame(() => {
  regl.clear({
    color: [0, 0, 0, 1]
  })
  camera(() => {
    drawBunny()
  })
})