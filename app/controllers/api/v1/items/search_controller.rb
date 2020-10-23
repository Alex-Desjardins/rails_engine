class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.single_search_string(request.query_parameters)) unless params[:unit_price] || params[:merchant_id]
    render json: ItemSerializer.new(Item.single_search_integer(request.query_parameters)) if params[:unit_price] || params[:merchant_id]
  end

  def index
    render json: ItemSerializer.new(Item.multi_search_string(request.query_parameters)) unless params[:unit_price] || params[:merchant_id]
    render json: ItemSerializer.new(Item.multi_search_integer(request.query_parameters)) if params[:unit_price] || params[:merchant_id]
  end
end
