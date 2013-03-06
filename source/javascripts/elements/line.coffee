Grasp.Line = Grasp.Element.extend
  initialize: (opts={}) ->
    Grasp.Element.prototype.initialize.apply(this, arguments)

    @line = @add @createLine()

    @canvas.on "mouse:move", (info) =>
      [offsetX, offsetY] = @cursorOffset(info)
      @line.set "x2", offsetX
      @line.set "y2", offsetY
      @updateCoords()

    @canvas.on "mouse:up", (info) =>
      @canvas.off "mouse:move"
      @canvas.off "mouse:up"

  createLine: ->
    new fabric.Line @options.coords,
      fill: "#f00"
      strokeWidth: 2
      hasBorders: false
      hasControls: false

