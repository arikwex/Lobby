loaded = false
pending = 0
sprites = []

class FruitRenderer
  initRenderer: ->
    if loaded or pending > 0
      return
    # idle sprites
    sprites.push(@loadSprite('fruit-1'))
    sprites.push(@loadSprite('fruit-2'))
    sprites.push(@loadSprite('fruit-3'))
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

  render: (context) ->
    sprite = sprites[parseInt(@anim * 4) % 3]
    context.setTransform(1, 0, 0, 1, @pos.x - sprite.width / 2.0 * 0.27, @pos.y - sprite.height * 0.33)
    context.scale(0.33, 0.33)
    context.drawImage(sprite, 0, 0)
    return

module.exports = FruitRenderer