class SpreeAOD.Views.AircraftDetail extends Backbone.View

  template: JST['aircraft_details/aircraft_detail']

  events:
    'submit #new_aircraft_detail': 'createOrSaveAircraftDetail'

  render: ->
    $(@el).html(@template(aircraft_detail: @model))
    this

  createOrSaveAircraftDetail: (event) ->
    event.preventDefault()
    attributes =  {line_item_id: @model.get('line_item_id'),aircraft_type: $('#new_aircraft_detail_aircraft_type').val(), year: $('#new_aircraft_detail_year').val()}

    @model.save attributes,  # this will POST or PUT, depending on isNew()
      wait: true
      success: @handleSuccess
      error: @handleError

  handleSuccess: () =>
    alert('saved: id=' + @model.get('id')) # TODO: we'll update a global flash message
    # alert('and our next mandatory detail is: ' + SpreeAOD.nextIncompleteDetail())
    SpreeAOD.nextIncompleteDetail()

  handleError: (aircraft_detail, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages

  #showAircraftData: ->
  #  Backbone.history.navigate("aircraft_detail/#{@model.get('id')}", true)
  #
  #