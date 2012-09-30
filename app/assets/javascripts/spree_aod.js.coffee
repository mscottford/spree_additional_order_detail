window.SpreeAOD =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  MandatoryDetails: []
  DetailModelMap: {}

  init: ->
    new SpreeAOD.Routers.Main()
    Backbone.history.start() #pushState: true)
  enableCheckout: ->
    $('#checkout-link').show()

  nextIncompleteDetail: ->
    # find the next incomplete detail to collect, if one exists
    for s in SpreeAOD.MandatoryDetails
      alert(SpreeAOD.DetailModelMap[s].isNew())
      if SpreeAOD.DetailModelMap[s].isNew()
        # set it's tab to active
        $(".nav-tabs .tab_" + s).tab('show')
        break

$(document).ready ->
  SpreeAOD.init()
