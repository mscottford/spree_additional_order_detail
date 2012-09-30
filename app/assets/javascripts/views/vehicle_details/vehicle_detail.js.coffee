class SpreeAOD.Views.VehicleDetail extends Backbone.View

  template: JST['vehicle_details/vehicle_detail']

  events:
    'submit #new_vehicle_detail': 'createOrSaveVehicleDetail'

  render: ->
    $(@el).html(@template(vehicle_detail: @model))
    this

  createOrSaveVehicleDetail: (event) ->
    event.preventDefault()
    attributes =  {line_item_id: @model.get('line_item_id'),make: $('#new_vehicle_detail_make').val(), year: $('#new_vehicle_detail_year').val()}

    @model.save attributes,  # this will POST or PUT, depending on isNew()
      wait: true
      success: @handleSuccess
      error: @handleError

  handleSuccess: () =>
    alert('saved: id=' + @model.get('id')) # TODO: we'll update a global flash message
    SpreeAOD.nextIncompleteDetail()

  handleError: (vehicle_detail, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages
