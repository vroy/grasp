# Hold a drawn line and update state as it is moved around.
Grasp.Line = Backbone.View.extend
  initialize: (canvas, coords, opts={}) ->
    @canvas = canvas
    @coords = coords

    @createLine()
    @createSmallCircle()
    @createArrow()

    @canvas.add(@line, @small, @arrow)

    @line.on  "moving", (e) => @moveLine(@line)
    @small.on "moving", (e) => @movePoint(@small)
    @arrow.on "moving", (e) => @movePoint(@arrow)

  createLine: ->
    @line = new fabric.Line(@coords, strokeWidth: 2, hasBorders: false, hasControls: false)

  createSmallCircle: ->
    @small = new fabric.Circle(radius: 4, hasBorders: false, hasControls: false)
    @small.left = @line.x1
    @small.top  = @line.y1
    @small.line = @line
    @small.point_index = "1"

  createArrow: ->
    @arrow = new fabric.Triangle(height: 25, width: 18, hasControls: false, hasBorders: false, hasRotatingPoint: false)
    @arrow.left = @line.x2
    @arrow.top  = @line.y2
    @arrow.point_index = "2"
    @arrow.line = @line
    @updateArrowAngle()

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


# Old functions for drawing lines:


# lineMouseDown = (e) ->
#   position = $jq_canvas.offset()
#   x1 = e.e.pageX - position.left
#   y1 = e.e.pageY - position.top

#   $line = new fabric.Line [x1, y1, x1, y1], stroke: "blue", strokeWidth: 5

#   canvas.add($line)
#   canvas.renderAll()

#   $trackingLine = true
#   canvas.selection = false
#   canvas.on "mouse:up", lineMouseUp
#   canvas.on "mouse:move", lineMouseMove

# lineMouseUp = (e) ->
#   return unless $trackingLine
#   position = $jq_canvas.offset()
#   x2 = e.e.pageX - position.left
#   y2 = e.e.pageY - position.top

#   $line.set("x2", x2).set("y2", y2)
#   canvas.renderAll()

#   canvas.off "mouse:up", lineMouseUp
#   canvas.off "mouse:move", lineMouseMove
#   $trackingLine = false
#   canvas.selection = true

# lineMouseMove = (e) ->
#   return unless $trackingLine

#   position = $jq_canvas.offset()
#   x2 = e.e.pageX - position.left
#   y2 = e.e.pageY - position.top

#   $line.set("x2", x2).set("y2", y2)
#   canvas.renderAll()

# lineMouseDown = (e) ->
#   position = $jq_canvas.offset()
#   x1 = e.e.pageX - position.left
#   y1 = e.e.pageY - position.top

#   $line = new fabric.Line [x1, y1, x1, y1], stroke: "blue", strokeWidth: 5

#   canvas.add($line)
#   canvas.renderAll()

#   $trackingLine = true
#   canvas.selection = false
#   canvas.on "mouse:up", lineMouseUp
#   canvas.on "mouse:move", lineMouseMove
