_ = require('underscore')
GemModel = require('./GemModel')
GemRenderer = require('./GemRenderer')

class Gem
  constructor: (x, y) ->
    @initModel()
    @initRenderer()
    @pos.x = x
    @pos.y = y
    return

_.extend(Gem.prototype, GemModel.prototype)
_.extend(Gem.prototype, GemRenderer.prototype)

module.exports = Gem