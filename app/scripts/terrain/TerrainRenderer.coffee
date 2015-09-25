terrainImg = null

class TerrainRenderer
  initRenderer: ->
    terrainImg = document.createElement('img')
    terrainImg.src = 'images/background.png'
    return

  render: (context) ->
    context.setTransform(1, 0, 0, 1, 0, 0)
    context.drawImage(terrainImg, 0, 0)
    return

module.exports = TerrainRenderer