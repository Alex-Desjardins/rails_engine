class Api::V1::Merchants::SearchController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.single_search_string(request.query_parameters))
  end

  def index
    render json: MerchantSerializer.new(Merchant.multi_search_string(request.query_parameters))
  end
end
