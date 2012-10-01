# /app/assets/javascripts/views/<%= model_class_name.pluralize.underscore %>/<%= model_class_name.underscore %>.js.coffee
class SpreeAOD.Views.<%= model_class %> extends Backbone.View

  template: JST['<%= model_class_name.pluralize.underscore %>/<%= model_class_name.underscore %>']

  events:
    'submit #new_<%= model_class_name.underscore %>': 'createOrSave<%= model_class %>'

  render: ->
    $(@el).html(@template(<%= model_class_name.underscore %>: @model))
    this

  createOrSave<%= model_class %>: (event) ->
    event.preventDefault()
    attributes =  {line_item_id: @model.get('line_item_id'),make: $('#new_<%= model_class_name.underscore %>_make').val(), year: $('#new_<%= model_class_name.underscore %>_year').val()}

    @model.save attributes,  # this will POST or PUT, depending on isNew()
      wait: true
      success: @handleSuccess
      error: @handleError

  handleSuccess: () =>
    alert('saved: id=' + @model.get('id')) # TODO: we'll update a global flash message
    SpreeAOD.nextIncompleteDetail()

  handleError: (<%= model_class_name.underscore %>, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages
