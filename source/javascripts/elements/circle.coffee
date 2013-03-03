Grasp.Circle = Grasp.Element.extend
  initialize: (opts={}) ->
    Grasp.Element.prototype.initialize.apply(this, arguments)

    @circle = @add @createCircle()

  createCircle: ->
    new fabric.Circle
      radius: 100
      fill: "transparent"
      stroke: "#f00"
      hasBorders: false
      hasControls: false
      left: @options.coords[0]
      top:  @options.coords[1]
