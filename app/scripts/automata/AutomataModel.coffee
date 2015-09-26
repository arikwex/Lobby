Character = require('../character/Character')

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
    @holding = null
    @MAX_SPEED = 30
    return

  update: (dT) ->
    # Chase current target
    if @target? and @disabled <= 0
      dx = @pos.x - @target.x
      dy = @pos.y - @target.y
      @heading = Math.atan2(dy, -dx)
      dist = Math.sqrt(dx * dx + dy * dy * 4)
      if dist > 70
        @propel(100 * dT)
      else
        @randomizeTarget()

    # holding
    if @holding?
      @holding.pos.x = @pos.x + Math.cos(@heading) * 50
      @holding.pos.y = @pos.y - Math.sin(@heading) * 20 - 8
      @holding.height = 42
      @holding.angle = Math.PI / 2 - @heading

    # Handle angle wrapping
    if @heading > Math.PI * 2
      @heading -= Math.PI * 2
    if @heading < 0
      @heading += Math.PI * 2

    # collisions
    @checkCollisions()

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

  checkCollisions: ->
    Automata = require('./Automata')
    for uid, entity of @world.entities
      if entity == @
        continue
      # if (entity instanceof Character) and @characterCollision(entity)
      #   # @collid(entity)
      #   break
      if (entity instanceof Automata) and @automataCollision(entity)
        @collideAutomata(entity)
        break
    return

  characterCollision: (character) ->
    if @held or character.holding or
       Math.sqrt(@vel.x * @vel.x + @vel.y * @vel.y) > 20
      return
    dx = character.pos.x - @pos.x
    dy = character.pos.y - @pos.y
    if dx > -10 and dx < 10 and dy > -10 and dy < 30
      return true
    return false

  automataCollision: (automata) ->
    dx = automata.pos.x - @pos.x
    dy = automata.pos.y - @pos.y
    if dx * dx + dy * dy * 4 < 70 * 70
      return true
    return false

  collideAutomata: (automata) ->
    dx = automata.pos.x - @pos.x
    dy = automata.pos.y - @pos.y
    @pos.x -= dx * 0.005
    @pos.y -= dy * 0.005
    @vel.x -= dx * 0.5
    @vel.y -= dy * 0.5
    @randomizeTarget()
    automata.randomizeTarget()
    return

  setTarget: (@target) -> return

  randomizeTarget: ->
    @target =
      x: Math.random() * @world.canvas.$el.width()
      y: Math.random() * @world.canvas.$el.height()
    return

  propel: (impulse) ->
    @vel.x += Math.cos(@heading) * impulse
    @vel.y -= Math.sin(@heading) * impulse
    return

  hold: (obj) ->
    @holding = obj
    return

  throw: () ->
    if @holding?
      @holding.release()
      @holding.vHeight = 50
      @holding.vel.x = @vel.x * 2
      @holding.vel.y = @vel.y * 2
      @holding = null
    return


module.exports = AutomataModel