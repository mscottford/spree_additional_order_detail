class SpreeAOD.Routers.Main extends Backbone.Router
  routes:
    '': 'populateTabs'
    'refetch': 'refetch'
    'next': 'nextTab'

  initialize: ->
    SpreeAOD.MandatoryDetails = $('#mandatory_details').data('mandatory-details')

    if SpreeAOD.MandatoryDetails.indexOf('vehicle_detail') != -1
      attrs = $('.container_vehicle_detail').data('vehicle-detail')
      attrs['vehicle_detail']['line_item_id'] = $('.container_vehicle_detail').data('line-item-id')
      @vehicleDetailModel = new SpreeAOD.Models.VehicleDetail(attrs['vehicle_detail'])
      SpreeAOD.DetailModelMap['vehicle_detail'] = @vehicleDetailModel

    #if SpreeAOD.MandatoryDetails.indexOf('aircraft_detail') != -1
    #  attrs = $('.container_aircraft_detail').data('aircraft-detail')
    #  attrs['aircraft_detail']['line_item_id'] = $('.container_aircraft_detail').data('line-item-id')
    #  @aircraftDetailModel = new SpreeAOD.Models.AircraftDetail()
    #  SpreeAOD.DetailModelMap['aircraft_detail'] = @AircraftDetailModel


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
