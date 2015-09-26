loaded = false
pending = 0
sprites =
  idle: []
  walk: []

class CharacterRenderer
  initRenderer: ->
    if loaded or pending > 0
      return
    # Idle anim
    sprites.idle.push(@loadSprite('idle-1'))
    sprites.idle.push(@loadSprite('idle-2'))
    sprites.idle.push(@loadSprite('idle-3'))
    sprites.idle.push(@loadSprite('idle-4'))
    # Walk anim
    sprites.walk.push(@loadSprite('walk-1'))
    sprites.walk.push(@loadSprite('walk-2'))
    sprites.walk.push(@loadSprite('walk-3'))
    sprites.walk.push(@loadSprite('walk-4'))
    return

  loadSprite: (name) ->
    pending++
    img = document.createElement('img')
    img.src = "images/character/#{name}.png"
    img.onload = =>
      pending--
      if pending == 0
        loaded = true
      return
    return img

  render: (context) ->
    spriteSequence = sprites.idle
    if @state == @STATES.WALKING
      spriteSequence = sprites.walk
    sprite = spriteSequence[parseInt(@anim * 6) % 4]
    context.setTransform(1, 0, 0, 1, @pos.x - sprite.width / 2.0 * 0.33, @pos.y - sprite.height * 0.33)
    if @direction
      context.scale(0.33, 0.33)
    else
      context.translate(sprite.width * 0.33, 0)
      context.scale(-0.33, 0.33)
    context.drawImage(sprite, 0, 0)
    return

module.exports = CharacterRenderer