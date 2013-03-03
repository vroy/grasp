Grasp.Ellipse = Grasp.Element.extend
  initialize: (opts={}) ->
    Grasp.Element.prototype.initialize.apply(this, arguments)

    @ellipse = @add @createEllipse()
    @tracking = true

    @canvas.on "mouse:move", (info) =>
      if @tracking
        offset = @canvas.el.offset()

        offsetX = info.e.pageX - offset.left
        rx = (offsetX - @options.x) / 2
        if rx > 0
          @ellipse.left = @options.x + rx
          @ellipse.rx = rx

        offsetY = info.e.pageY - offset.top
        ry = (offsetY - @options.y) / 2
        if ry > 0
          @ellipse.top = @options.y + ry
          @ellipse.ry = ry

        @canvas.renderAll()

    @canvas.on "mouse:up", (info) =>
      @tracking = false

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
