class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.find_by("#{key} ILIKE '%#{value}%'")) unless params[:unit_price] || params[:merchant_id]
    render json: ItemSerializer.new(Item.find_by("#{key}": value)) if params[:unit_price] || params[:merchant_id]
  end

  def index
    render json: ItemSerializer.new(Item.where("#{key} ILIKE '%#{value}%'")) unless params[:unit_price] || params[:merchant_id]
    render json: ItemSerializer.new(Item.where("#{key}": value)) if params[:unit_price] || params[:merchant_id]
  end
end
