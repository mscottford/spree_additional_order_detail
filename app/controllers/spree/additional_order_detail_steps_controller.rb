module Spree
  class AdditionalOrderDetailStepsController < BaseController
    include Wicked::Wizard

    def index
    end

    def show
    end

    private
      def redirect_to_finish_wizard
        redirect_to checkout_state_path(@order.checkout_steps.first)
      end
  end
end
