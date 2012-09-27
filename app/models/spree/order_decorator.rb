module Spree
  Order.class_eval do
    def additional_detail_steps
      line_items.map { |li| li.additional_detail_steps }.flatten.uniq.map(&:to_sym)
    end

    # the next step of the order detail collection that we need 
    def current_step
      additional_detail_steps.each do |step|
        return step if line_items.any? { |li| li.needs_additional_detail_for?(step) }
      end

      return :finish
    end
    def requires_additional_detail?
      line_items.any? { |li| li.requires_additional_detail? }
    end

    # has 0 or some number less than 100% 
    def incomplete_additional_detail?
      line_items.any? { |li| li.incomplete_additional_detail? }
    end

    # has 1 or some number less than 100% 
    def partial_additional_detail?
      incomplete_additional_detail? &&
        line_items.any? { |li| li.has_additional_detail? }
    end

    # has 1 or some number up to and including 100% 
    def has_additional_detail?
      line_items.any? { |li| li.has_additional_detail? }
    end
  end
end
