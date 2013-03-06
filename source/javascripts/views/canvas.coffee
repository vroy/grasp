Grasp.Canvas = Backbone.View.extend
  initialize: (el) ->
    @el = el
    @canvas = new fabric.Canvas(@el.get(0), selection: false)
    @canvas.el = @el

    Grasp.options = new Grasp.Options el: $("#options"), canvas: @canvas
    @objects = [ ]

    # @inspector()

    fabric.Image.fromURL "/images/example.png", (img) =>
      img.scaleToWidth(@canvas.width)
      img.scaleToHeight(@canvas.height)
      img.set originX: 'left', originY: 'top', selectable: false
      @canvas.add(img)

    @canvas.on "mouse:down", (info) =>
      offset = @el.offset()
      x = info.e.pageX - offset.left
      y = info.e.pageY - offset.top

      switch Grasp.options.currentElementType()
        when "line"      then @startLine(info.target, x, y)
        when "ellipse"   then @startEllipse(info.target, x ,y)
        when "text"      then @startText(info.target, x, y, info.e)
        when "rect" then @startRect(info.target, x, y)
        when "trash"     then @trashElement(info.target)

  trashElement: (target) ->
    return unless target?

    _.each @objects, (obj) ->
      obj.dispose() if obj.id == target.unique_id

  startText: (target, x, y, e) ->
    return if target? # Only proceed if outside of an existing element.
    @objects.push new Grasp.Text(canvas: @canvas, e: e, x: x, y: y)

  startLine: (target, x, y) ->
    return if target? # Only proceed if outside of an existing element.
    @objects.push new Grasp.Line(canvas: @canvas, coords: [x, y, x, y])

  startEllipse: (target, x, y) ->
    return if target? # Only proceed if outside of an existing element.
    @objects.push new Grasp.Ellipse(canvas: @canvas, x: x, y: y)

  startRect: (target, x, y) ->
    return if target? # Only proceed if outside of an existing element.
    @objects.push new Grasp.Rect(canvas: @canvas, x: x, y: y)


  inspector: ->
    events = [
      "object:modified", "object:selected",
      "object:moving", "object:scaling", "object:rotating",
      "before:selection:cleared", "selection:cleared", "selection:created",
      "mouse:up", "mouse:down", "mouse:move",
      "after:render",
      "path:created", "object:added"
    ]
    _.each events, (event) =>
      @canvas.on event, (info) -> console.log "#{event}(%o, %o)", info.e, info.target
