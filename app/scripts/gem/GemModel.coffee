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
    @angle = 0
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
      if @height < 16
        @vHeight = -@vHeight * 0.6
        @vel.x -= @vel.x * 0.75
        @vel.y -= @vel.y * 0.75
        @height = 16
      @angle = 0
    else
      @height = 20 + Math.cos(@anim * Math.PI * 2) * 4

    # collisions
    @checkCollisions()

    # motion
    @pos.x += @vel.x * dT
    @pos.y += @vel.y * dT
    return

  checkCollisions: ->
    for uid, entity of @world.entities
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
    if @held or @scale < 1
      return
    dx = automata.pos.x - @pos.x
    dy = automata.pos.y - @pos.y
    if dx > -40 and dx < 40 and dy > -5 and dy < 25
      return true
    return false

  collect: (entity) ->
    entity.hold(@)
    @held = true
    return

  release: ->
    @held = false
    return

  collideAutomata: (automata) ->
    # Normal
    nx = @pos.x - automata.pos.x
    ny = @pos.y - (automata.pos.y - 15)
    mag = Math.sqrt(nx * nx + ny * ny)
    nx /= mag
    ny /= mag
    if Math.cos(Math.atan2(-ny, nx) - automata.heading) > 0.7 and not automata.holding? and not @held
      @collect(automata)
      @vel.x = 0
      @vel.y = 0
      return
    # Incident ray
    ix = -automata.vel.x
    iy = -automata.vel.y
    mag = Math.sqrt(ix * ix + iy * iy)
    if mag == 0
      mag = 0.01
    ix /= mag
    iy /= mag
    # semi-momentum transfer to gem
    @vel.x = (nx * 0.2 - ix * 0.8) * mag * 2
    @vel.y = (ny * 0.2 - iy * 0.8) * mag * 2
    return

module.exports = GemModel