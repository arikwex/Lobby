loaded = false
pending = 0
sprites = []

class PlantRenderer
  initRenderer: ->
    if loaded or pending > 0
      return
    # idle sprites
    sprites.push(@loadSprite('plant-1'))
    sprites.push(@loadSprite('plant-2'))
    sprites.push(@loadSprite('plant-3'))
    sprites.push(@loadSprite('plant-2'))
    return

  loadSprite: (name) ->
    pending++
    img = document.createElement('img')
    img.src = "images/plant/#{name}.png"
    img.onload = =>
      pending--
      if pending == 0
        loaded = true
      return
    return img

  render: (context) ->
    sprite = sprites[parseInt(@anim * 3) % 4]
    context.setTransform(1, 0, 0, 1, @pos.x - sprite.width / 2.0 * 0.66, @pos.y - sprite.height * 0.66)
    context.scale(0.66, 0.66)
    context.drawImage(sprite, 0, 0)
    return

module.exports = PlantRenderer