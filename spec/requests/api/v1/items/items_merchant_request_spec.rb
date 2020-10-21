require 'rails_helper'

RSpec.describe 'Items Merchant' do
  it 'returns items merchant' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    random_merchants = 2.times {create(:merchant)}

    get "/api/v1/items/#{item.id}/merchant"
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    items_json = JSON.parse(response.body, symbolize_names: true)
    expect(Merchant.all.count).to eq(3)
    expect(items_json.count).to eq(1)
    expect(items_json[:data][:type]).to eq("merchant")
    expect(items_json[:data][:id]).to eq(merchant.id.to_s)
    expect(items_json[:data][:attributes][:id]).to eq(merchant.id)
    expect(items_json[:data][:attributes][:name]).to eq(merchant.name)
  end
end
