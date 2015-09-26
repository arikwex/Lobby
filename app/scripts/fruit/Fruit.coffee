_ = require('underscore')
FruitModel = require('./FruitModel')
FruitRenderer = require('./FruitRenderer')

class Fruit
  constructor: (x, y) ->
    @initModel()
    @initRenderer()
    @pos.x = x
    @pos.y = y
    return

_.extend(Fruit.prototype, FruitModel.prototype)
_.extend(Fruit.prototype, FruitRenderer.prototype)

module.exports = Fruit