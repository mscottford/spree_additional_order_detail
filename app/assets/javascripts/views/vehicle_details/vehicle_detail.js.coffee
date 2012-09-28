class SpreeAOD.Views.VehicleDetail extends Backbone.View

  template: JST['vehicle_details/vehicle_detail']
  tagName: 'li'

  #events:
  #  'click': 'showVehicleData'

  render: ->
    $(@el).html(@template(vehicle_detail: @model))
    this

  #showVehicleData: ->
  #  Backbone.history.navigate("vehicle_detail/#{@model.get('id')}", true)