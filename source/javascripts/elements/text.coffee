Grasp.Text = Grasp.Element.extend
  initialize: (opts={}) ->
    Grasp.Element.prototype.initialize.apply(this, arguments)

    @text  = @add @createText()

    # @todo Clicking away from the textarea should remove the textarea.
    # @todo Dispose of objects and unbind events, cause you know, memory

    $("body").on "dblclick", (e) =>
      target = @canvas.findTarget(e)
      if target?
        @createTextarea(target, e.pageX, e.pageY)

    @createTextarea(@text, @options.e.pageX, @options.e.pageY)

  createTextarea: (target, x, y) ->
    previous_text = target.text
    area = $("<textarea id='area' />").val(target.text).css(width: 300, height: 50, position: "absolute", left: x-150, top: y-25).on "keydown", (e) =>
      if e.keyCode == 27 # escape
        e.preventDefault()
        $(e.currentTarget).remove()

      if e.keyCode == 13 and !(e.shiftKey or e.ctrlKey) # enter
        e.preventDefault()
        target.text = $(e.currentTarget).val()
        @canvas.renderAll()
        $(e.currentTarget).remove()

    $("body").append(area)
    area.focus()

  createText: ->
    new fabric.Text "",
      left: @options.x
      top: @options.y
      fill: "#f00"
      hasBorders: false
      hasControls: false
