window.SpreeAOD =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new SpreeAOD.Routers.VehicleDetails()
    Backbone.history.start() #pushState: true)

$(document).ready ->
  SpreeAOD.init()
