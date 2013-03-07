Grasp.Options = Backbone.View.extend
  events:
    "click [name=dump-json-to-console]": "dumpToConsole"
    "click [name=dump-open-as-image]": "openAsImage"
    "change [name=element-type]": "typeChanged"

  initialize: (opts={}) ->
    @el = opts.el
    @canvas = opts.canvas

    key '1,2,3,4,5,6,7,8', (event, handler) =>
      @el.find("[data-option-id]").prop("checked", false)

      target = @el.find("[data-option-id=#{handler.key}]")
      target.prop("checked", true)

      @typeChanged(currentTarget: target)

  currentElementType: ->
    @el.find("input:checked").val()

  typeChanged: (e) ->
    @canvas.isDrawingMode = ($(e.currentTarget).val() == "drawing")

  dumpToConsole: ->
    console.log JSON.stringify( @canvas.toJSON() )

  openAsImage: ->
    window.open @canvas.toDataURL(format: "png")
