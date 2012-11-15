module Spree
  class AdditionalOrderDetailsController < BaseController
    before_filter :load_order

    respond_to :html, :js

    def main
      @additional_order_details = assemble_relevant_details  ### todo, sort/group?
    end

    def create
      @additional_order_detail = AdditionalOrderDetail.create(params[:additional_order_detail])
      respond_with @additional_order_detail
    end

    def update
      @additional_order_detail = AdditionalOrderDetail.find(params[:id])
      @additional_order_detail.update_attributes(params[:additional_order_detail])
      respond_with @additional_order_detail
    end

    private
      def model_class_for_step(step)
        # eat it Demeter!
        Spree::AdditionalOrderDetailDescriptor.where(:step_name => step.to_s).limit(1).first.model_name.constantize
      end

      def load_order
        @order = current_order
        redirect_to cart_path and return unless @order && @order.checkout_allowed?
        raise_insufficient_quantity and return if @order.insufficient_stock_lines.present?
        redirect_to cart_path and return if @order.completed?
      end


      # which line items need additional order detail for this step?
      def assemble_relevant_details
        additional_order_details = []

        # for line item,
        @order.line_items.each do |line_item| 

          # and each type of of info that needs to be collected
          @order.additional_detail_steps.each do |step|

            if line_item.requires_additional_detail_for?(step)

              # we either have one, or need to create one

              if line_item.needs_additional_detail_for?(step)
                # we need one

                # build and attach the additional order detail
                # then build the specific associated model
                additional_order_detail = line_item.additional_order_details.build
                additional_order_detail.detailed = model_class_for_step(step).new(additional_order_detail: additional_order_detail)
                additional_order_details << additional_order_detail
              else
                # we have detail for this step already, so grab it
                additional_order_details << line_item.additional_detail_for(step)
              end
            end # requires?
          end # steps.each
        end # @order.line_items.each

        additional_order_details
      end
  end
end
