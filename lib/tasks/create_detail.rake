require 'highline/import'
require 'erb'

namespace :aod do
  desc "Creates a bunch of scaffolding for a new detail type"
  task :create_scaffold => :environment do
    say("Make sure you have already run your bundle exec rails g model (for this new detail type) and subsequent migrations before continuing")
    model_class_name =ask('class name of new model (e.g. VehicleDetail) ').to_s
    model_class = model_class_name.constantize
    camel_case_model = model_class_name[0, 1].downcase + model_class_name[1..-1]

    aod_loc = `bundle show spree_additional_order_detail`.strip

    file = File.open("#{aod_loc}/templates/details_controller.rb", "r")
    contents = file.read

    template = ERB.new(contents)
    
    FileUtils.mkdir_p('./app/controllers/spree')
    File.open("./app/controllers/spree/#{model_class_name.pluralize.underscore}_controller.rb", "w") {|f| f.write(template.result(binding)) }

    file = File.open("#{aod_loc}/templates/model_detail.js.coffee", "r")
    contents = file.read

    template = ERB.new(contents)
    
    FileUtils.mkdir_p('./app/assets/javascripts/models')
    File.open("./app/assets/javascripts/models/#{model_class_name.underscore}.js.coffee", "w") {|f| f.write(template.result(binding)) }


    file = File.open("#{aod_loc}/templates/template_detail.jst.eco", "r")
    contents = file.read

    template = ERB.new(contents)
    path = "./app/assets/templates/#{model_class_name.underscore.pluralize}"
    FileUtils.mkdir_p(path)
    File.open("#{path}/#{model_class_name.underscore}.jst.eco", "w") {|f| f.write(template.result(binding)) }



    file = File.open("#{aod_loc}/templates/view_detail.js.coffee", "r")
    contents = file.read

    template = ERB.new(contents)
    
    FileUtils.mkdir_p("./app/assets/javascripts/views/#{model_class_name.underscore.pluralize}")
    File.open("./app/assets/javascripts/views/#{model_class_name.underscore.pluralize}/#{model_class_name.underscore}.js.coffee", "w") {|f| f.write(template.result(binding)) }

    say "

Make sure you have this in your application.rb

    initializer \"spree.register.additional_order_detail_models\" do |app|
      app.config.spree.additional_order_detail_models += [
                                                         #{model_class_name}
                                                        ]
      end
"

    say "
Make sure you adjust createOrSave* in your view file!!!!
"

    say "
Make sure you put this in your model file:

  self.include_root_in_json = false

  def as_json(options={})
    super(options.merge(except: [:created_at, :updated_at]))
  end
"

    say "

TODO: need to smartly update the main router file(./app/assets/javascripts/routers/main.js.coffee), but for now, copy it from the extension and update w/ lines like:
 within the initialize function: 

    if SpreeAOD.MandatoryDetails.indexOf('#{model_class_name.underscore}') != -1
      attrs = $('.container_#{model_class_name.underscore}').data('#{model_class_name.underscore.gsub('_','-')}')
      attrs['line_item_id'] = $('.container_#{model_class_name.underscore}').data('line-item-id')
      @#{camel_case_model}Model = new SpreeAOD.Models.#{model_class_name}(attrs)
      SpreeAOD.DetailModelMap['#{model_class_name.underscore}'] = @#{camel_case_model}Model

then in populateTabs:

  if SpreeAOD.MandatoryDetails.indexOf('#{model_class_name.underscore}') != -1
    view = new SpreeAOD.Views.#{model_class_name}(model: @#{camel_case_model}Model)
    $('.container_#{model_class_name.underscore}').html(view.render().el)


"

    say "
You will need to customize your template at: ./app/assets/templates/#{model_class_name.underscore}/#{model_class_name.underscore}.jst.eco"

    say "
Also add your routes.rb:
      scope '/api' do
        resources :#{model_class_name.underscore.pluralize}
      end"
end
end
