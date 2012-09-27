module Spree
  class AdditionalOrderDetailStepsController < BaseController
    include Wicked::Wizard

    steps :dummy

    before_filter :load_order
    before_filter :determine_steps

    def show
      # for each applicable line item,
      # build and attach the additional order detail
      # then build the specific associated model in preparation for 
      # showing the page
      select_relevant_line_items { |line_item| 
        additional_order_detail = line_item.additional_order_details.build
        additional_order_detail.detailed = step.to_s.constantize.new
      }

      # when :finish
      #  redirect_to_finish_wizard and return
      # end
      render_wizard
    end

    private
      def load_order
        @order = current_order
        redirect_to cart_path and return unless @order && @order.checkout_allowed?
        raise_insufficient_quantity and return if @order.insufficient_stock_lines.present?
        redirect_to cart_path and return if @order.completed?
      end

      def determine_steps
        self.class.steps= @order.additional_detail_steps
      end

      def redirect_to_finish_wizard
        redirect_to checkout_state_path(@order.checkout_steps.first)
      end

      # which line items need additional order detail for this step?
      def select_relevant_line_items
        @line_items = @order.line_items.
                            select { |line_item| 
                                      line_item.needs_additional_detail_for?(step) 
                            }

        @line_items.each { |line_item|
          yield line_item
        }
      end

  end
end
