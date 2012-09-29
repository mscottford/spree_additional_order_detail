class SpreeAOD.Collections.AdditionalOrderDetails extends Backbone.Collection
  url: '/api/additional_order_details'
  model: (attrs, options) ->
    switch attrs.type
      when 'VehicleDetail' then new VehicleDetail attrs, options
      when 'AircraftDetail' then new AircraftDetail attrs, options
      # should probably add an 'else' here so there's a default if,
      # say, no attrs are provided to a Logbooks.create call
