Grasp.Canvas = Backbone.View.extend
  initialize: (el) ->
    @el = el
    @canvas = new fabric.Canvas(@el.get(0), selection: false, freeDrawingColor: "#f00", freeDrawingLineWidth: 2)
    @canvas.el = @el

    Grasp.options = new Grasp.Options el: $("#options"), canvas: @canvas
    @objects = [ ]

    fabric.Image.fromURL "/images/example.png", (img) =>
      img.scaleToWidth(@canvas.width)
      img.scaleToHeight(@canvas.height)
      img.set originX: 'left', originY: 'top', selectable: false
      @canvas.add(img)

    # Track objects created from free drawing.
    @canvas.on "object:added", (info) =>
      if info.target.type == "path"
        info.target.hasBorders = false
        info.target.hasControls = false
        info.target.unique_id = _.uniqueId()
        @objects.push info.target

    @canvas.on "mouse:down", (info) =>
      offset = @el.offset()
      x = info.e.pageX - offset.left
      y = info.e.pageY - offset.top

      switch Grasp.options.currentElementType()
        when "arrow"   then @startArrow(info.target, x, y)
        when "line"    then @startLine(info.target, x, y)
        when "ellipse" then @startEllipse(info.target, x ,y)
        when "text"    then @startText(info.target, x, y, info.e)
        when "rect"    then @startRect(info.target, x, y)
        when "trash"   then @trashElement(info.target)

  findObjectsByUniqueId: (target) ->
    _.filter @objects, (obj) -> obj.id == target.unique_id

  trashElement: (target) ->
    return if !target?

    _.each @findObjectsByUniqueId(target), (obj) ->
      if _.isFunction(obj.dispose)
        obj.dispose()
      else if _.isFunction(obj.remove)
        obj.remove()

  startText: (target, x, y, e) ->
    return if target? # Only proceed if outside of an existing element.
    @objects.push new Grasp.Text(canvas: @canvas, e: e, x: x, y: y)

  startArrow: (target, x, y) ->
    return if target? # Only proceed if outside of an existing element.
    @objects.push new Grasp.Arrow(canvas: @canvas, coords: [x, y, x, y])

  startLine: (target, x, y) ->
    return if target? # Only proceed if outside of an existing element.
    @objects.push new Grasp.Line(canvas: @canvas, coords: [x, y, x, y])

  startEllipse: (target, x, y) ->
    return if target? # Only proceed if outside of an existing element.
    @objects.push new Grasp.Ellipse(canvas: @canvas, x: x, y: y)

  startRect: (target, x, y) ->
    return if target? # Only proceed if outside of an existing element.
    @objects.push new Grasp.Rect(canvas: @canvas, x: x, y: y)
