class SpreeAOD.Routers.VehicleDetails extends Backbone.Router
  routes:
    'vehicle_details': 'index'
    'vehicle_details/:id': 'show'

  initialize: ->
    @collection = new SpreeAOD.Collections.VehicleDetails()
    @collection.reset($('#container').data('vehicle-details'))

  index: ->
    view = new SpreeAOD.Views.VehicleDetailsIndex(collection: @collection)
    $('#container').html(view.render().el)

  show: (id) ->
    alert "vehicle_detail: #{id}"