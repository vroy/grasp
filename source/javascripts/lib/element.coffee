Grasp.Element = Backbone.View.extend
  initialize: (opts={}) ->
    @canvas = opts.canvas
    @opts = opts

    @id = _.uniqueId()
    @objects ||= [ ]

  add: (child, key=null) ->
    @[key] = child if key
    child.unique_id = @id
    @objects.push(child)
    @canvas.add(child)
    child

  dispose: ->
    _.each @objects, (obj) -> obj.remove()

  # When modifying objects via mouse events, it does not always allow you to
  # select the element immediately. That is caused by the fact that the canvas
  # is not kept in sync with the new dimensions/location of the object.
  updateCoords: ->
    @canvas.renderAll()
    _.each @objects, (obj) -> obj.setCoords()
