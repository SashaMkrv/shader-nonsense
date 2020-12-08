/*
  tags: basic, lines
  <p> This example demonstrates how to draw line loops and line strips . </p>
*/

const regl = require('regl')()
const glslify = require('glslify')
var mat4 = require('gl-mat4')
var rng = require('seedrandom')('my_seed')

var globalState = regl({
  uniforms: {
    tick: ({tick}) => tick,
    projection: ({viewportWidth, viewportHeight}) =>
      mat4.perspective([],
                       Math.PI / 4,
                       viewportWidth / viewportHeight,
                       0.01,
                       1000),
    view: mat4.lookAt([], [2.1, 0, 2.1], [0, 0.0, 0], [0, 0, 1])
  },
  frag: glslify('./shaders/line.fs.glsl'),
  vert: glslify('./shaders/line.vs.glsl'),
})

// make sure to respect system limitations.
var lineWidth = 3
if (lineWidth > regl.limits.lineWidthDims[1]) {
  lineWidth = regl.limits.lineWidthDims[1]
}

// this creates a drawCall that allows you to do draw single line primitive.
function createDrawCall (props) {
  return regl({
    attributes: {
      position: props.position
    },

    uniforms: {
      color: props.color,
      scale: props.scale,
      offset: props.offset,
      phase: props.phase,
      freq: props.freq
    },

    lineWidth: lineWidth,
    count: props.position.length,
    primitive: props.primitive
  })
}

var drawCalls = []
var i

// draw a spiral.
N = 120
drawCalls.push(createDrawCall({
  color: [0.3, 0.8, 0.76],
  primitive: 'line strip',
  scale: 0.25,
  offset: [0.0, 0.0],
  phase: 0.6,
  freq: 0.015,
  position: Array(N).fill().map((_, i) => {
    var phi = 2 * Math.PI * (i / N)
    phi *= 5.0
    var A = 0.03
    return [A * (Math.cos(phi) + phi * Math.sin(phi)), A * (Math.sin(phi) - phi * Math.cos(phi))]
  })
}))

regl.frame(({tick}) => {
  regl.clear({
    color: [0, 0, 0, 1],
    depth: 1
  })

  globalState(() => {
    for (i = 0; i < drawCalls.length; i++) {
      drawCalls[i]()
    }
  })
})