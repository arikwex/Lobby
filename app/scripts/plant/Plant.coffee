_ = require('underscore')
PlantModel = require('./PlantModel')
PlantRenderer = require('./PlantRenderer')

class Plant
  constructor: (x, y) ->
    @initModel()
    @initRenderer()
    @pos.x = x
    @pos.y = y
    return

_.extend(Plant.prototype, PlantModel.prototype)
_.extend(Plant.prototype, PlantRenderer.prototype)

module.exports = Plant