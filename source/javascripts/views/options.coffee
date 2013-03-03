Grasp.Options = Backbone.View.extend
  initialize: (opts={}) ->
    @el = opts.el

  currentElementType: ->
    @el.find("input:checked").val()
