module Spree
  class Admin::AdditionalOrderDetailDescriptorsController < Admin::ResourceController
    before_filter :load_object, :only => [:selected, :available, :remove]

    def available
      set_available_additional_order_detail_descriptors
      render :layout => false
    end

    def selected
      @additional_order_detail_descriptors = @object.additional_order_detail_descriptors
    end

    def remove
      @object.additional_order_detail_descriptors.delete(@additional_order_detail_descriptor)
      @object.save
      flash.notice = I18n.t("notice_messages.additional_order_detail_descriptor_removed")
      redirect_to appropriate_route
    end

    # AJAX method for selecting an existing option type and associating with the current object
    def select
      @object = find_appropriate_object
      model_name = params[:additional_order_detail_model_name]
      @object.additional_order_detail_descriptors.create(step_name: model_name.split("::").last.underscore.to_sym, model_name: model_name)

      @additional_order_detail_descriptors = @object.additional_order_detail_descriptors
      set_available_additional_order_detail_descriptors
    end

    protected

    private

    def appropriate_route
      return selected_admin_product_additional_order_detail_descriptors_url(@object) if @object.kind_of?(Spree::Product)
      return selected_admin_option_value_additional_order_detail_descriptors_url(@object) if @object.kind_of?(Spree::OptionValue)
    end

    def find_appropriate_object
      return Product.find_by_param!(params[:product_id]) if params[:product_id]
      return OptionValue.find(params[:option_value_id]) if params[:option_value_id]
    end

    def load_object
      @object = Product.find_by_param!(params[:product_id]) if params[:product_id]
      @object = OptionValue.find(params[:option_value_id]) if params[:option_value_id]
    end

    def set_available_additional_order_detail_descriptors
      @available_additional_order_detail_models = Rails.application.config.spree.additional_order_detail_models.dup

      selected_additional_order_detail_models = []
      @object.additional_order_detail_descriptors.each do |d|
        selected_additional_order_detail_models << d
      end

      @available_additional_order_detail_models.delete_if {|m| selected_additional_order_detail_models.map(&:model_name).include? m.to_s}
    end
  end
end
