class Controller
  constructor: ->
    @keys = new Array(256)
    window.onkeydown = => @onKeyDown.apply(@, arguments)
    window.onkeyup = => @onKeyUp.apply(@, arguments)
    return

  bind: (@target) -> return

  onKeyDown: (evt) ->
    identifier = evt.keyIdentifier
    @keys[evt.keyCode] = true
    @checkTriggers()

  checkTriggers: ->
    vel =
      x: 0
      y: 0
    if @keys[39] then vel.x += 1
    if @keys[37] then vel.x -= 1
    if @keys[38] then vel.y -= 1
    if @keys[40] then vel.y += 1
    if vel.x != 0 or vel.y != 0
      @target?.walk(vel)
    else
      @target?.idle()
    return

  onKeyUp: (evt) ->
    @keys[evt.keyCode] = false
    @checkTriggers()
    return

module.exports = Controller