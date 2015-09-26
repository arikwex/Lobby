class AutomataModel
  initModel: ->
    @pos =
      x: 0
      y: 0
    @vel =
      x: 0
      y: 0
    @heading = 0
    @disabled = 1
    @MAX_SPEED = 30
    return

  update: (dT) ->
    # Chase current target
    if @target? and @disabled <= 0
      @heading = Math.atan2(-@target.y + @pos.y, @target.x - @pos.x)
      @propel(100 * dT)

    # Handle angle wrapping
    if @heading > Math.PI * 2
      @heading -= Math.PI * 2
    if @heading < 0
      @heading += Math.PI * 2

    # Locamotion
    @pos.x += @vel.x * dT
    @pos.y += @vel.y * dT
    if @disabled > 0
      @vel.x -= @vel.x * 0.5 * dT
      @vel.y -= @vel.y * 0.5 * dT
      @disabled -= dT

    # limit max speed
    mag = Math.sqrt(@vel.x * @vel.x + @vel.y * @vel.y)
    if mag > @MAX_SPEED
      @vel.x /= mag
      @vel.y /= mag
      @vel.x *= @MAX_SPEED
      @vel.y *= @MAX_SPEED
    return

  setTarget: (@target) -> return

  propel: (impulse) ->
    @vel.x += Math.cos(@heading) * impulse
    @vel.y -= Math.sin(@heading) * impulse
    return


module.exports = AutomataModel