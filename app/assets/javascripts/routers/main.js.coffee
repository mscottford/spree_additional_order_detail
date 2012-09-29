class SpreeAOD.Routers.Main extends Backbone.Router
  routes:
    '': 'populateTabs'
    'refetch': 'refetch'

  initialize: ->
    #@collection.reset($('#container').data('vehicle-details'))
    attrs = $('.container_vehicle_detail').data('vehicle-detail')
    attrs['vehicle_detail']['line_item_id'] = $('.container_vehicle_detail').data('line-item-id')
    @vehicleDetailModel = new SpreeAOD.Models.VehicleDetail(attrs['vehicle_detail'])
    #@aircraftDetailModel = new SpreeAOD.Models.VehicleDetail()

  populateTabs: ->
    view = new SpreeAOD.Views.VehicleDetail(model: @vehicleDetailModel)
    $('.container_vehicle_detail').html(view.render().el)
    # $('.container_AircraftDetail').html(view.render().el)

  refetch: ->
    @collection = new SpreeAOD.Collections.AdditionalOrderDetails()
    @collection.fetch()

    #view = new SpreeAOD.Views.VehicleDetail(model: @vehicledetailModel)
    #$('.container_vehicle_detail').html(view.render().el)
    # $('.container_AircraftDetail').html(view.render().el)
