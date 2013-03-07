Grasp.Ellipse = Grasp.Element.extend
  initialize: (opts={}) ->
    Grasp.Element.prototype.initialize.apply(this, arguments)

    @ellipse = @add @createEllipse()

    @canvas.on "mouse:move", (info) => @resizeEllipse(info)
    @canvas.on "mouse:up", (info) => @stopResize(info)

  stopResize: (info) ->
    @canvas.off "mouse:move"
    @canvas.off "mouse:up"

  resizeEllipse: (info) ->
    [offsetX, offsetY] = @cursorOffset(info)

    width = offsetX - @options.x
    @ellipse.width = Math.abs(width)
    @ellipse.rx = @ellipse.width/2
    @ellipse.left = @options.x + width/2

    height = offsetY - @options.y
    @ellipse.height = Math.abs(height)
    @ellipse.ry = @ellipse.height/2
    @ellipse.top = @options.y + height/2

    @updateCoords()

  createEllipse: ->
    new fabric.Ellipse
      rx: 1
      ry: 1
      fill: "transparent"
      stroke: "#f00"
      strokeWidth: 3
      hasBorders: false
      hasControls: false
      left: @options.x
      top:  @options.y
