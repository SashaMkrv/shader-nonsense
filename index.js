/*
  tags: basic
 <p> This example shows how to use copyTexImage2D to implement feedback effects </p>
 */

const regl = require('regl')()
const mouse = require('mouse-change')()
const glslify = require('glslify')

const pixels = regl.texture()

const drawFeedback = regl({
  frag: glslify('./shaders/example.fs.glsl'),
  vert: glslify('./shaders/example.vs.glsl'),

  attributes: {
    position: [
      -2, 0,
      0, -2,
      2, 2]
  },

  uniforms: {
    texture: pixels,
    mouse: ({pixelRatio, viewportHeight}) => [
      mouse.x * pixelRatio,
      viewportHeight - mouse.y * pixelRatio
    ],
    t: ({tick}) => 0.005 * tick
  },

  count: 3
})

regl.frame(function () {
  regl.clear({
    color: [0, 0, 1.0, 1]
  })

  drawFeedback()

  pixels({
    copy: true,
  })
})