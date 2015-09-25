$ = require('jquery')
World = require('./World')
Canvas = require('./Canvas')
Controller = require('./Controller')
Terrain = require('./terrain/Terrain')
Character = require('./character/Character')
Automata = require('./automata/Automata')

$(->
  world = new World()
  canvas = new Canvas()
  world.bind(canvas)

  terrain = new Terrain()
  world.add(terrain)

  character = new Character()
  world.add(character)

  controller = new Controller()
  controller.bind(character)

  automaton = new Automata()
  world.add(automaton)
  automaton.setTarget(character.pos)

  world.run()
  $('body').append(canvas.$el)
)