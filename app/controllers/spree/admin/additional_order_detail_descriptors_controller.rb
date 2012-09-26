module Spree
  class Admin::AdditionalOrderDetailDescriptorsController < Admin::ResourceController
    before_filter :load_product, :only => [:selected, :available, :remove]

    def available
      set_available_additional_order_detail_descriptors
      render :layout => false
    end

    def selected
      @additional_order_detail_descriptors = @product.additional_order_detail_descriptors
    end

    def remove
      @product.additional_order_detail_descriptors.delete(@additional_order_detail_descriptor)
      @product.save
      flash.notice = I18n.t("notice_messages.additional_order_detail_descriptor_removed")
      redirect_to selected_admin_product_additional_order_detail_descriptors_url(@product)
    end


    # AJAX method for selecting an existing option type and associating with the current product
    def select
      @product = Product.find_by_param!(params[:product_id])
      model_name = params[:additional_order_detail_model_name]
      @product.additional_order_detail_descriptors.create(name: model_name, model_name: model_name)

      @additional_order_detail_descriptors = @product.additional_order_detail_descriptors
      set_available_additional_order_detail_descriptors
    end

    protected

    private
    def load_product
      @product = Product.find_by_param!(params[:product_id])
    end

    def set_available_additional_order_detail_descriptors
      @available_additional_order_detail_models = Rails.application.config.spree.additional_order_detail_models.dup

      selected_additional_order_detail_models = []
      @product.additional_order_detail_descriptors.each do |d|
        selected_additional_order_detail_models << d
      end

      @available_additional_order_detail_models.delete_if {|m| selected_additional_order_detail_models.map(&:model_name).include? m.to_s}
    end
  end
end
