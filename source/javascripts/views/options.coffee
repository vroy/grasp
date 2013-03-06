Grasp.Options = Backbone.View.extend
  events:
    "click [name=dump-json-to-console]": "dumpToConsole"
    "click [name=dump-open-as-image]": "openAsImage"

  initialize: (opts={}) ->
    @el = opts.el
    @canvas = opts.canvas

    key '1,2,3,4,5,6,7', (event, handler) =>
      @el.find("[data-option-id]").prop("checked", false)
      @el.find("[data-option-id=#{handler.key}]").prop("checked", true)

  currentElementType: ->
    @el.find("input:checked").val()

  dumpToConsole: ->
    console.log JSON.stringify( @canvas.toJSON() )

  openAsImage: ->
    window.open @canvas.toDataURL(format: "png")
