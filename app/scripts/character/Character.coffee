_ = require('underscore')
CharacterModel = require('./CharacterModel')
CharacterRenderer = require('./CharacterRenderer')

class Character
  constructor: (x, y) ->
    @initModel()
    @initRenderer()
    @pos.x = x
    @pos.y = y
    return

_.extend(Character.prototype, CharacterModel.prototype)
_.extend(Character.prototype, CharacterRenderer.prototype)

module.exports = Character