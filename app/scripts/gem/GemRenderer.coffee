loaded = false
pending = 0
sprites = []
shadows = []

class GemRenderer
  initRenderer: ->
    if loaded or pending > 0
      return
    # idle sprites
    sprites.push(@loadSprite('gem-1'))
    sprites.push(@loadSprite('gem-2'))
    sprites.push(@loadSprite('gem-3'))
    sprites.push(@loadSprite('gem-4'))
    # shadow sprites
    shadows.push(@loadSprite('../components/shadow-1'))
    shadows.push(@loadSprite('../components/shadow-2'))
    shadows.push(@loadSprite('../components/shadow-3'))
    shadows.push(@loadSprite('../components/shadow-4'))
    return

  loadSprite: (name) ->
    pending++
    img = document.createElement('img')
    img.src = "images/gem/#{name}.png"
    img.onload = =>
      pending--
      if pending == 0
        loaded = true
      return
    return img

  renderShadow: (context) ->
    # shadow
    sprite = shadows[parseInt(@anim * 3) % 4]
    context.setTransform(1, 0, 0, 1, @pos.x, @pos.y + 2)
    context.scale(0.6 - @height / 100.0, 0.6 - @height / 100.0)
    context.translate(-sprite.width / 2, -sprite.height / 2.0)
    context.drawImage(sprite, 0, 0)
    return

  render: (context) ->
    sprite = sprites[parseInt(@anim * 4) % 4]
    context.setTransform(1, 0, 0, 1, @pos.x, @pos.y - @height)
    context.scale(0.4, 0.4)
    context.rotate(@angle)
    context.translate(-sprite.width / 2, -sprite.height / 2)
    context.drawImage(sprite, 0, 0)
    return

module.exports = GemRenderer