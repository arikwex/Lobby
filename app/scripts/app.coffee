$ = require('jquery')
World = require('./World')
Canvas = require('./Canvas')
Controller = require('./Controller')
Terrain = require('./terrain/Terrain')
Character = require('./character/Character')
Automata = require('./automata/Automata')
Plant = require('./plant/Plant')
Fruit = require('./fruit/Fruit')
Gem = require('./gem/Gem')

$(->
  world = new World()
  canvas = new Canvas()
  world.bind(canvas)

  terrain = new Terrain()
  world.add(terrain)

  character = new Character(400, 300)
  world.add(character)
  world.player = character

  controller = new Controller()
  controller.bind(character)

  for i in [0..5]
    automaton = new Automata(Math.random() * 500 + 150, Math.random() * 300 + 150)
    world.add(automaton)
    automaton.setTarget(character.pos)

  for i in [0..5]
    plant = new Plant(Math.random() * 500 + 150, Math.random() * 300 + 150)
    world.add(plant)

  for i in [0..5]
    gem = new Gem(Math.random() * 500 + 150, Math.random() * 300 + 150)
    world.add(gem)

  world.run()
  $('body').append(canvas.$el)
)