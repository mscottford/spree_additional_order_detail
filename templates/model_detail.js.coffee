# app/assets/javascripts/models/<%= model_class_name.underscore %>.js.coffee
class SpreeAOD.Models.<%= model_class %> extends Backbone.Model
  urlRoot: '/api/<%= model_class_name.pluralize.underscore %>'

  # could do something like
  # http://lostechies.com/derickbailey/2011/06/15/binding-a-backbone-view-to-a-model-to-enable-and-disable-a-button/
  #events:
