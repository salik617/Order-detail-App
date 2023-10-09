require 'httparty'
require 'json'
class OrderDetailsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create, :update]


    def create
      @order_detail = OrderDetail.new(order_detail_params)

      if @order_detail.save
        notify_third_party_apis('create', @order_detail)
      else
      end
    end

    def update
      @order_detail = OrderDetail.find(params[:id])

      if @order_detail.update(order_detail_params)
        notify_third_party_apis('update', @order_detail)
      else
      end
    end

    private

    def notify_third_party_apis(action, order_detail)
      third_party_endpoints = [
        ENV['third_party_api_1'],
        ENV['third_party_api_2']
      ]

      third_party_endpoints.each do |endpoint|
        begin
          WebhookWorker.new.perform(endpoint, order_detail)
        rescue OrderDetails::AuthorizationFailedError
          return
        end
      end
    end

    def order_detail_params
      params.require(:order_detail).permit(:product_name, :quantity, :description, :price, :order_date)
    end

end
