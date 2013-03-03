Grasp.Canvas = Backbone.View.extend
  initialize: (el) ->
    @el = el
    @canvas = new fabric.Canvas(@el.get(0), selection: false)
    @objects = [ ]

    @objects.push new Grasp.Line(@canvas, [100, 100, 100, 200])
    @objects.push new Grasp.Line(@canvas, [300, 300, 400, 200])

    @canvas.on "mouse:down", (info) =>
      if !info.target? # Only proceed if the cursor is not already applied to a previous element
        offset = @el.offset()
        x = info.e.pageX - offset.left
        y = info.e.pageY - offset.top
        @objects.push new Grasp.Line(@canvas, [x, y, x, y], fire: true)
