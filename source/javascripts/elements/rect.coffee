Grasp.Rect = Grasp.Element.extend
  initialize: (opts={}) ->
    Grasp.Element.prototype.initialize.apply(this, arguments)

    @rect = @add @createRect()

    @canvas.on "mouse:move", (info) => @resizeRect(info)
    @canvas.on "mouse:up", (info) => @stopResize(info)

  stopResize: (info) ->
    @canvas.off "mouse:move"
    @canvas.off "mouse:up"

  resizeRect: (info) ->
    [offsetX, offsetY] = @cursorOffset(info)

    rx = (offsetX - @options.x) / 2
    if rx > 0
      @rect.left = @options.x + rx
      @rect.width = rx * 2

    ry = (offsetY - @options.y) / 2
    if ry > 0
      @rect.top = @options.y + ry
      @rect.height = ry * 2

    @updateCoords()

  createRect: ->
    new fabric.Rect
      fill: "transparent"
      stroke: "#f00"
      strokeWidth: 3
      hasBorders: false
      hasControls: false
      left: @options.x
      top:  @options.y
