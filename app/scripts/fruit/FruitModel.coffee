class FruitModel
  initModel: ->
    @pos =
      x: 0
      y: 0
    @anim = 0
    return

  update: (dT) ->
    @anim += dT
    if @anim > 3
      @anim -= 3
    return

module.exports = FruitModel