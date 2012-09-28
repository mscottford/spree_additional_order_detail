class SpreeAOD.Views.VehicleDetailsIndex extends Backbone.View

  template: JST['vehicle_details/index']

  events:
    'submit #new_vehicle_detail': 'createVehicleDetail'

  # THIS is the key part to make sure the view gets updated (due to the
  # async issue mentioned around 16:15 of
  # http://railscasts.com/episodes/323-backbone-on-rails-part-1?autoplay=true
  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendVehicleDetail, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendVehicleDetail)
    this

  createVehicleDetail: (event) ->
    event.preventDefault()
    attributes =  {make: $('#new_vehicle_detail_make').val(), year: $('#new_vehicle_detail_year').val()}
    @collection.create attributes,
      wait: true # to ensure we have success before adding a blank to the form
      # clear the form
      success: -> $('#new_vehicle_detail')[0].reset()
      error: @handleError

  appendVehicleDetail: (vehicle_detail) ->
    view = new SpreeAOD.Views.VehicleDetail(model: vehicle_detail)
    $('#vehicle_details').append(view.render().el)

  handleError: (vehicle_detail, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages

