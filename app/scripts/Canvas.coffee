$ = require('jquery')

class Canvas
  WIDTH: 800
  HEIGHT: 600

  constructor: ->
    @$el = $('<canvas>')
    @$el.get(0).width = @WIDTH
    @$el.get(0).height = @HEIGHT
    @context = @$el.get(0).getContext('2d')
    return

module.exports = Canvas