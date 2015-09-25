_ = require('underscore')
TerrainRenderer = require('./TerrainRenderer')

class Terrain
  constructor: ->
    @initRenderer()
    return

_.extend(Terrain.prototype, TerrainRenderer.prototype)

module.exports = Terrain