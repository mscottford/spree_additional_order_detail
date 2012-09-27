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
      @line_items = select_relevant_line_items { |line_item| 
        if line_item.additional_order_details.empty?
          additional_order_detail = line_item.additional_order_details.build
          additional_order_detail.detailed = model_class_for_step.new
        end
      }

      render_wizard
    end

    def update
binding.pry
      # params[:order][:line_items_attributes].values.map { |v| v.delete('id') }

      ActiveRecord::Base.transaction do
        @line_items = @order.line_items
        begin

          params[:order][:line_items_attributes].values.each do |v| 

            line_item = @line_items.detect { |li| li.id == v["id"].to_i }

            if attrs = v["additional_order_details_attributes"]["detailed_attributes"]
              # existing record?
              binding.pry 
              # how to get existing aod?
              # line_item.additional_order_details.upd....
            else attrs = v["additional_order_detail"]["detailed_attributes"]
              # new record
              model = model_class_for_step.new(v["additional_order_details_attributes"]["detailed_attributes"])

              unless model.save
                @order.errors[:base] << model.errors.full_messages  # TODO: this needs some love
              end

              line_item.additional_order_details.create!(detailed: model)
            end
          end # end params

        rescue => ex
          render_step(step) and return
        end
      end

      #render_step(next_step)
      render_wizard(@order)
    end

    private
      def model_class_for_step
        # eat it Demeter!
        Spree::AdditionalOrderDetailDescriptor.where(:step_name => step.to_s).limit(1).first.model_name.constantize
      end
      def load_order
        @order = current_order
        redirect_to cart_path and return unless @order && @order.checkout_allowed?
        raise_insufficient_quantity and return if @order.insufficient_stock_lines.present?
        redirect_to cart_path and return if @order.completed?
      end

      def determine_steps
        self.class.steps(@order.additional_detail_steps)
      end

      def finish_wizard_path
        checkout_state_path(@order.checkout_steps.first)
      end

      # which line items need additional order detail for this step?
      def select_relevant_line_items
        @line_items = @order.line_items.
                            select { |line_item| 
                                      # line_item.needs_additional_detail_for?(step) 
                                      line_item.requires_additional_detail_for?(step)
                            }

        @line_items.each { |line_item|
          yield line_item
        }

        @line_items
      end

  end
end
