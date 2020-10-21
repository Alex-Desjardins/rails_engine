require 'rails_helper'

RSpec.describe 'Merchant Items' do
  it 'returns merchant items' do
    merchant = create(:merchant)
    5.times {create(:item, merchant: merchant)}
    random_items = 2.times {create(:item)}

    get "/api/v1/merchants/#{merchant.id}/items"
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    items_json = JSON.parse(response.body, symbolize_names: true)
    expect(Item.all.count).to eq(7)
    expect(items_json[:data].count).to eq(5)
    expect(items_json[:data].first[:id]).to eq(merchant.items.first.id.to_s)
    expect(items_json[:data].first[:attributes][:name]).to eq(merchant.items.first.name)
  end
end
