window.SpreeAOD =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new SpreeAOD.Routers.Main()
    Backbone.history.start() #pushState: true)

$(document).ready ->
  SpreeAOD.init()
