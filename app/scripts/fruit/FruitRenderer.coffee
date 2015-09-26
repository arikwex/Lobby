loaded = false
pending = 0
sprites = []
breaking = []
shadows = []

class FruitRenderer
  initRenderer: ->
    if loaded or pending > 0
      return
    # idle sprites
    sprites.push(@loadSprite('fruit-1'))
    sprites.push(@loadSprite('fruit-2'))
    sprites.push(@loadSprite('fruit-3'))
    # breaking sprites
    breaking.push(@loadSprite('break-1'))
    breaking.push(@loadSprite('break-2'))
    breaking.push(@loadSprite('break-3'))
    breaking.push(@loadSprite('break-4'))
    # shadow sprites
    shadows.push(@loadSprite('../components/shadow-1'))
    shadows.push(@loadSprite('../components/shadow-2'))
    shadows.push(@loadSprite('../components/shadow-3'))
    shadows.push(@loadSprite('../components/shadow-4'))
    return

  loadSprite: (name) ->
    pending++
    img = document.createElement('img')
    img.src = "images/fruit/#{name}.png"
    img.onload = =>
      pending--
      if pending == 0
        loaded = true
      return
    return img

  renderShadow: (context) ->
    # shadow
    if not @planted
      scale = 1
      if @decaying
        scale = (4.0 - @anim) / 4.0
      sprite = shadows[parseInt(@anim * 3) % 4]
      context.setTransform(1, 0, 0, 1, @pos.x, @pos.y + 2)
      context.scale((0.6 - @height / 100.0) * scale, (0.6 - @height / 100.0) * scale)
      context.translate(-sprite.width / 2, -sprite.height / 2.0)
      context.drawImage(sprite, 0, 0)
    return

  render: (context) ->
    # fruit
    sprite = sprites[parseInt(@anim * 4) % 3]
    if @decaying
      sprite = breaking[parseInt(@anim)]
    offset = 0
    if @planted
      offset = -Math.abs(Math.cos(@anim * Math.PI * 2 / 3.0) * 7)
    context.setTransform(1, 0, 0, 1, @pos.x, @pos.y + offset - @height)
    context.rotate(@angle)
    context.scale(0.33 * @scale, 0.33 * @scale)
    context.translate(-sprite.width / 2.0, -sprite.height / 2.0)
    context.drawImage(sprite, 0, 0)
    return

module.exports = FruitRenderer