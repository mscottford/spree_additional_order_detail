module SpreeAdditionalOrderDetail
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_additional_order_detail'

#    ActiveRecord::Base.include_root_in_json = false

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc

    initializer "spree.register.additional_order_detail_models" do |app|
      app.config.spree.add_class('additional_order_detail_models')
      app.config.spree.additional_order_detail_models = [
                                                         ::VehicleDetail,
                                                         ::AircraftDetail
                                                        ]

# use these above to create descriptors in the admin app
    end
  end
end
