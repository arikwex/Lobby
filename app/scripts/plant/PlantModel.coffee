Fruit = require('../fruit/Fruit')

class PlantModel
  initModel: ->
    @pos =
      x: 0
      y: 0
    @anim = 0
    @fruit = null
    return

  update: (dT) ->
    @anim += dT
    if @anim > 4
      @anim -= 4
    # Grow the fruit
    if @fruit?
      @fruit?.grow()
    else
      @fruit = new Fruit(@pos.x, @pos.y - 28)
      @world.add(@fruit)
    return

module.exports = PlantModel