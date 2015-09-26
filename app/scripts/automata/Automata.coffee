_ = require('underscore')
AutomataModel = require('./AutomataModel')
AutomataRenderer = require('./AutomataRenderer')

class Automata
  constructor: (x, y) ->
    @initModel()
    @initRenderer()
    @pos.x = x
    @pos.y = y
    return

_.extend(Automata.prototype, AutomataModel.prototype)
_.extend(Automata.prototype, AutomataRenderer.prototype)

module.exports = Automata