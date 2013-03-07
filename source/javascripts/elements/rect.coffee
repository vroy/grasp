Grasp.Rect = Grasp.Element.extend
  initialize: (opts={}) ->
    Grasp.Element.prototype.initialize.apply(this, arguments)

    @rect = @add @createRect()

    @move_cb = (info) => @resizeRect(info)
    @up_cb = (info) => @stopResize(info)
    @canvas.on "mouse:move", @move_cb
    @canvas.on "mouse:up", @up_cb

  stopResize: (info) ->
    @canvas.off "mouse:move", @move_cb
    @canvas.off "mouse:up", @up_cb

  resizeRect: (info) ->
    [offsetX, offsetY] = @cursorOffset(info)

    @rect.width = offsetX - @options.x
    @rect.left = @options.x + @rect.width/2

    @rect.height = offsetY - @options.y
    @rect.top = @options.y + @rect.height/2

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
