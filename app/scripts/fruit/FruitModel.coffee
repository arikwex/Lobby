Character = require('../character/Character')
Automata = require('../automata/Automata')

class FruitModel
  initModel: ->
    @pos =
      x: 0
      y: 0
    @vel =
      x: 0
      y: 0
    @height = 0
    @vHeight = 0
    @anim = Math.random() * 3
    @scale = 0
    @angle = 0
    @GROW_RATE = 0.3
    @held = false
    @planted = true
    @decaying = false
    @MAX_IDLE_TIME = 8
    @idleTime = 3
    return

  update: (dT) ->
    # Animations
    if @decaying
      @anim += dT * 8
      if @anim > 4
        @anim = 4
        return true
    else
      @anim += dT
      if @anim > 3
        @anim -= 3
    # Holding
    if not @held
      @height += @vHeight * dT
      @vHeight -= 200 * dT
      if @height < 6
        @vHeight = -@vHeight * 0.6
        @vel.x -= @vel.x * 0.75
        @vel.y -= @vel.y * 0.75
        @height = 6
      if not @planted
        @idleTime -= dT
        if @idleTime <= 0 and not @decaying
          @decay()
    else
      @idleTime = @MAX_IDLE_TIME
    # Grow
    if @scale < 1
      @scale += dT * @GROW_RATE
    else
      @scale = 1
    # Collection
    @checkCollisions()
    # Motion
    @pos.x += @vel.x * dT
    @pos.y += @vel.y * dT
    @angle += Math.sqrt(@vel.x * @vel.x + @vel.y * @vel.y) / 100.0 * dT
    return

  checkCollisions: ->
    for uid, entity of @world.entities
      if (entity instanceof Character) and @characterCollision(entity)
        @collect(entity)
        break
      if (entity instanceof Automata) and @automataCollision(entity)
        @collideAutomata(entity)
        break
    return

  characterCollision: (character) ->
    if @held or @scale < 1 or @decaying or character.holding or
       Math.sqrt(@vel.x * @vel.x + @vel.y * @vel.y) > 20
      return
    dx = character.pos.x - @pos.x
    dy = character.pos.y - @pos.y
    if dx > -10 and dx < 10 and dy > -10 and dy < 30
      return true
    return false

  automataCollision: (automata) ->
    if @held or @scale < 1 or @planted or @decaying
      return
    dx = automata.pos.x - @pos.x
    dy = automata.pos.y - @pos.y
    if dx > -40 and dx < 40 and dy > -5 and dy < 35
      return true
    return false

  collect: (character) ->
    character.hold(@)
    @angle = 0
    @held = true
    @planted = false
    @plant?.detach()
    return

  release: ->
    @held = false
    return

  decay: ->
    @anim = 0
    @decaying = true
    @scale = 1.8
    return

  collideAutomata: (automata) ->
    @decay()
    # Normal
    nx = @pos.x - automata.pos.x
    ny = @pos.y - (automata.pos.y - 15)
    mag = Math.sqrt(nx * nx + ny * ny)
    nx /= mag
    ny /= mag
    # Incident ray
    ix = @vel.x
    iy = @vel.y
    mag = Math.sqrt(ix * ix + iy * iy)
    ix /= mag
    iy /= mag
    # R = I + 2 * N * (I.N)
    dot = nx * ix + ny * iy
    rx = ix - 2 * nx * dot
    ry = iy - 2 * ny * dot
    @vel.x = rx * mag
    @vel.y = ry * mag
    # momentum transfer
    automata.throw()
    automata.vel.x += nx * -60
    automata.vel.y += ny * -60
    automata.disabled = 2
    automata.setTarget(@world.player.pos)
    return

module.exports = FruitModel