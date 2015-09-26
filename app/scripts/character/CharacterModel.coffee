class CharacterModel
  initModel: ->
    @MAX_SPEED = 80
    @anim = 0
    @pos =
      x: 0
      y: 0
    @vel =
      x: 0
      y: 0
    @lastVel =
      x: 1
      y: 0
    @STATES =
      IDLE: 'Idle'
      WALKING: 'Walking'
    @state = @STATES.IDLE
    @direction = false
    @holding = null
    return

  update: (dT) ->
    @anim += dT
    if @anim > 4
      @anim -= 4
    @pos.x += @vel.x * dT
    @pos.y += @vel.y * dT
    if @holding?
      @holding.pos.x = @pos.x
      if @direction
        @holding.pos.x += 10
      else
        @holding.pos.x -= 10
      @holding.pos.y = @pos.y
      @holding.height = 22
      if @state == @STATES.IDLE
        @holding.height += Math.cos(@anim * Math.PI * 2) * 2
      else
        @holding.height += Math.cos(@anim * Math.PI * 3) * 3 - 2
    return

  idle: ->
    @state = @STATES.IDLE
    @vel =
      x: 0
      y: 0
    return

  walk: (vel) ->
    @state = @STATES.WALKING
    mag = Math.sqrt(vel.x * vel.x + vel.y * vel.y)
    vel.x /= mag
    vel.y /= mag
    @vel.x = vel.x * @MAX_SPEED
    @vel.y = vel.y * @MAX_SPEED
    @lastVel =
      x: vel.x
      y: vel.y
    @direction = vel.x > 0
    return

  hold: (obj) ->
    @holding = obj
    return

  throw: () ->
    if @holding?
      @holding.release()
      @holding.vHeight = 50
      @holding.vel.x = @lastVel.x * 250
      @holding.vel.y = @lastVel.y * 250
      @holding = null
    return

module.exports = CharacterModel