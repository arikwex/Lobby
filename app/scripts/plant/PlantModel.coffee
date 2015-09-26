Fruit = require('../fruit/Fruit')

class PlantModel
  initModel: ->
    @pos =
      x: 0
      y: 0
    @anim = Math.random() * 3
    @fruit = null
    return

  update: (dT) ->
    @anim += dT
    if @anim > 4
      @anim -= 4
    # Create a new fruit if one does not exist
    if not @fruit?
      @fruit = new Fruit(@pos.x, @pos.y - 35)
      @fruit.plant = @
      @world.add(@fruit)
    return

  detach: ->
    @fruit.plant = null
    @fruit = null
    return

module.exports = PlantModel