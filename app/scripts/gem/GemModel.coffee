Character = require('../character/Character')
Automata = require('../automata/Automata')

class GemModel
  initModel: ->
    @pos =
      x: 0
      y: 0
    @vel =
      x: 0
      y: 0
    @anim = Math.random() * 3
    @height = 10
    @vHeight = 0
    @held = false
    return

  update: (dT) ->
    # animation
    @anim += dT
    if @anim > 4
      @anim -= 4

    # holding
    if not @held
      @height += @vHeight * dT
      @vHeight -= 200 * dT
      if @height < 6
        @vHeight = -@vHeight * 0.6
        @vel.x -= @vel.x * 0.75
        @vel.y -= @vel.y * 0.75
        @height = 6
    else
      @height = 10 + Math.cos(@anim * Math.PI * 2) * 4

    # collisions
    @checkCollisions()

    # motion
    @pos.x += @vel.x * dT
    @pos.y += @vel.y * dT
    return

  checkCollisions: ->
    for uid, entity of @world.entities
      if (entity instanceof Character) and @characterCollision(entity)
        @collect(entity)
        break
      if (entity instanceof Automata) and @automataCollision(entity)
        # @collideAutomata(entity)
        break
    return

  characterCollision: (character) ->
    if @held or character.holding or
       Math.sqrt(@vel.x * @vel.x + @vel.y * @vel.y) > 20
      return
    dx = character.pos.x - @pos.x
    dy = character.pos.y - @pos.y
    if dx > -10 and dx < 10 and dy > 0 and dy < 40
      return true
    return false

  automataCollision: (automata) ->
    if @held or @scale < 1
      return
    dx = automata.pos.x - @pos.x
    dy = automata.pos.y - @pos.y
    if dx > -40 and dx < 40 and dy > -5 and dy < 35
      return true
    return false

  collect: (character) ->
    character.hold(@)
    @held = true
    return

  release: ->
    @held = false
    return

module.exports = GemModel