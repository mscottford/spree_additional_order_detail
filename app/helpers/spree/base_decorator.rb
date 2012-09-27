module Spree
  module BaseHelper
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
