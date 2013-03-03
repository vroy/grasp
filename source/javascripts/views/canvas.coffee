Grasp.Canvas = Backbone.View.extend
  initialize: (el) ->
    @el = el
    @canvas = new fabric.Canvas(@el.get(0), selection: false)
    @canvas.el = @el
    @objects = [ ]

    # @inspector()

    @canvas.on "mouse:down", (info) =>
      offset = @el.offset()
      x = info.e.pageX - offset.left
      y = info.e.pageY - offset.top

      switch Grasp.options.currentElementType()
        when "line"   then @startLine(info.target, x, y)
        when "circle" then @startCircle(info.target, x ,y)
        when "trash"  then @trashElement(info.target)

  trashElement: (target) ->
    return unless target?

    _.each @objects, (obj) ->
      obj.dispose() if obj.id == target.unique_id

  startLine: (target, x, y) ->
    return if target? # Only return if outside of an existing element.
    @objects.push new Grasp.Line(canvas: @canvas, coords: [x, y, x, y])

  startCircle: (target, x, y) ->
    return if target? # Only return if outside of an existing element.
    @objects.push new Grasp.Circle(canvas: @canvas, coords: [x, y])


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
