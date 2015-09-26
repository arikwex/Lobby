$ = require('jquery')
World = require('./World')
Canvas = require('./Canvas')
Controller = require('./Controller')
Terrain = require('./terrain/Terrain')
Character = require('./character/Character')
Automata = require('./automata/Automata')
Plant = require('./plant/Plant')
Fruit = require('./fruit/Fruit')

$(->
  world = new World()
  canvas = new Canvas()
  world.bind(canvas)

  terrain = new Terrain()
  world.add(terrain)

  character = new Character(400, 300)
  world.add(character)

  controller = new Controller()
  controller.bind(character)

  automaton = new Automata(300, 300)
  world.add(automaton)
  automaton.setTarget(character.pos)

  plant = new Plant(400, 400)
  world.add(plant)

  world.run()
  $('body').append(canvas.$el)
)