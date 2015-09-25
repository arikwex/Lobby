_ = require('underscore')
CharacterModel = require('./CharacterModel')
CharacterRenderer = require('./CharacterRenderer')

class Character
  constructor: ->
    @initModel()
    @initRenderer()
    return

_.extend(Character.prototype, CharacterModel.prototype)
_.extend(Character.prototype, CharacterRenderer.prototype)

module.exports = Character