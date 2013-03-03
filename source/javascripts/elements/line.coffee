# Hold a drawn line and update state as it is moved around.
Grasp.Line = Grasp.Element.extend
  initialize: (opts={}) ->
    Grasp.Element.prototype.initialize.apply(this, arguments)

    @line  = @add @createLine()
    @small = @add @createSmallCircle()
    @arrow = @add @createArrow()

    @line.on  "moving", (e) => @moveLine(@line)
    @small.on "moving", (e) => @movePoint(@small)
    @arrow.on "moving", (e) => @movePoint(@arrow)

    @canvas.on "mouse:move", (info) =>
      offset = @canvas.el.offset()
      @arrow.left = info.e.pageX - offset.left
      @arrow.top = info.e.pageY - offset.top
      @movePoint(@arrow)
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

  createSmallCircle: ->
    new fabric.Circle
      fill: "#f00"
      radius: 4
      hasBorders: false
      hasControls: false
      left: @line.x1
      top:  @line.y1
      line: @line
      point_index: "1"

  createArrow: ->
    new fabric.Triangle
      fill: "#f00"
      height: 25
      width: 18
      hasControls: false
      hasBorders: false
      hasRotatingPoint: false
      angle: 90
      left: @line.x2
      top:  @line.y2
      point_index: "2"
      line: @line

  updateArrowAngle: ->
    ydiff = @line.y2 - @line.y1
    xdiff = @line.x2 - @line.x1
    angle = Math.atan2(ydiff, xdiff) * (180 / Math.PI) + 90
    @arrow.set("angle", angle)

  moveLine: (target) ->
    @small.left = target.left - (target.width/2)
    @small.top  = target.top  - (target.height/2)
    [@line.x1, @line.y1] = [@small.left, @small.top]

    @arrow.left = target.left + (target.width/2)
    @arrow.top  = target.top  + (target.height/2)
    [@line.x2, @line.y2] = [@arrow.left, @arrow.top]

  movePoint: (target) ->
    @line.set("x#{target.point_index}", target.left)
    @line.set("y#{target.point_index}", target.top)
    @updateArrowAngle()
