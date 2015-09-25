class CharacterModel
  initModel: ->
    @anim = 0
    @pos =
      x: 400
      y: 300
    @vel =
      x: 0
      y: 0
    @STATES =
      IDLE: 'Idle'
      WALKING: 'Walking'
    @state = @STATES.IDLE
    @direction = false
    @MAX_SPEED = 80
    return

  update: (dT) ->
    @anim += dT
    if @anim > 4
      @anim -= 4
    @pos.x += @vel.x * dT
    @pos.y += @vel.y * dT
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
    @direction = vel.x > 0
    return

module.exports = CharacterModel