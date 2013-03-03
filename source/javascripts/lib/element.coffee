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
