loaded = false
pending = 0
sprites = []

class AutomataRenderer
  initRenderer: ->
    if loaded or pending > 0
      return
    # heading sprites
    sprites.push(@loadSprite('right'))
    sprites.push(@loadSprite('up'))
    sprites.push(@loadSprite('up'))
    sprites.push(@loadSprite('up'))
    sprites.push(@loadSprite('right'))
    sprites.push(@loadSprite('down-right'))
    sprites.push(@loadSprite('down'))
    sprites.push(@loadSprite('down-right'))
    return

  loadSprite: (name) ->
    pending++
    img = document.createElement('img')
    img.src = "images/automata/#{name}.png"
    img.onload = =>
      pending--
      if pending == 0
        loaded = true
      return
    return img

  render: (context) ->
    sprite = sprites[parseInt(@heading * 8 / (Math.PI * 2) + 0.5) % 8]
    context.setTransform(1, 0, 0, 1, @pos.x - sprite.width / 2.0 * 0.33, @pos.y - sprite.height * 0.33)
    if Math.cos(@heading) > 0
      context.scale(0.33, 0.33)
    else
      context.translate(sprite.width * 0.33, 0)
      context.scale(-0.33, 0.33)
    context.drawImage(sprite, 0, 0)
    return

module.exports = AutomataRenderer