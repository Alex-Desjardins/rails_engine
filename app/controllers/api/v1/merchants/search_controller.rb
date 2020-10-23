class Api::V1::Merchants::SearchController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.find_by("name ILIKE '%#{value}%'"))
  end

  def index
    render json: MerchantSerializer.new(Merchant.where("name ILIKE '%#{value}%'"))
  end
end
