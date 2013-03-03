Grasp.Circle = Grasp.Element.extend
  initialize: (opts={}) ->
    Grasp.Element.prototype.initialize.apply(this, arguments)

    @circle = @add @createCircle()

    @trackingCircle = true

    @canvas.on "mouse:move", (info) =>
      if @trackingCircle
        offset = @canvas.el.offset()
        offsetX = info.e.pageX - offset.left
        radius = offsetX - @options.coords[0]

        if radius > 0
          @circle.setRadius(radius)
          @circle.left = @options.coords[0] + radius
          @circle.top = @options.coords[1] + radius
          @canvas.renderAll()

    @canvas.on "mouse:up", (info) =>
      @trackingCircle = false

  createCircle: ->
    new fabric.Circle
      radius: 1
      fill: "transparent"
      stroke: "#f00"
      strokeWidth: 3
      hasBorders: false
      hasControls: false
      left: @options.coords[0]
      top:  @options.coords[1]
