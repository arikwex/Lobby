class World
  constructor: ->
    @lastTime = 0
    @UID = 0
    @canvas = null
    @entities = {}
    return

  add: (entity) ->
    entity.UID = @UID
    @UID++
    @entities[entity.UID] = entity
    return

  remove: (entity) ->
    delete @entities[entity.UID]
    return

  bind: (@canvas) -> return

  run: ->
    window.requestAnimationFrame((timestamp) => @onFrame(timestamp))
    return

  onFrame: (timestamp) ->
    dT = (timestamp - @lastTime) / 1000.0
    if dT > 0.1
      dT = 0.1
    @lastTime = timestamp
    @update(dT)
    window.requestAnimationFrame((timestamp) => @onFrame(timestamp))
    return

  update: (dT) ->
    removeHash = {}
    for uid, entity of @entities
      toRemove = entity.update?(dT)
      if toRemove
        removeHash[uid] = entity
      if @canvas?
        # TODO: render order by Y value
        entity.render(@canvas.context)
    for uid, entity of removeHash
      @remove(entity)
    return

module.exports = World