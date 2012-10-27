module Spree
  module BaseHelper
    def additional_order_detail_remove_route_for(object, desc)
      route = case object
                when Spree::Product
                  remove_admin_product_additional_order_detail_descriptor_url(object, desc)
                when Spree::OptionValue
                  remove_admin_option_value_additional_order_detail_descriptor_url(object, desc)
              end
    end

    def additional_order_detail_available_route_for(object)
      route = case object
              when Spree::Product
                available_admin_product_additional_order_detail_descriptors_url(object)
              when Spree::OptionValue
                available_admin_option_value_additional_order_detail_descriptors_url(object)
              end
    end
  
    def additional_order_detail_steps(order)
      states = order.additional_detail_steps
      items = states.map do |state|
        #        text = t("order_state.#{state}").titleize
        text = state.to_s.titleize

        css_classes = [] # ['current']

        text = link_to text, additional_order_detail_step_path(state)

        content_tag('li', content_tag('span', text), :class => css_classes.join('-'))
      end
      content_tag('ol', raw(items.join("\n")), :class => 'progress-steps')
    end
  end
end
