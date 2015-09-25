_ = require('underscore')
AutomataModel = require('./AutomataModel')
AutomataRenderer = require('./AutomataRenderer')

class Automata
  constructor: ->
    @initModel()
    @initRenderer()
    return

_.extend(Automata.prototype, AutomataModel.prototype)
_.extend(Automata.prototype, AutomataRenderer.prototype)

module.exports = Automata