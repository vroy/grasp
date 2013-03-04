Grasp.Options = Backbone.View.extend
  events:
    "click [name=dump-json-to-console]": "dumpToConsole"
    "click [name=dump-open-as-image]": "openAsImage"

  initialize: (opts={}) ->
    @el = opts.el
    @canvas = opts.canvas

  currentElementType: ->
    @el.find("input:checked").val()

  dumpToConsole: ->
    console.log JSON.stringify( @canvas.toJSON() )

  openAsImage: ->
    window.open @canvas.toDataURL(format: "png")
