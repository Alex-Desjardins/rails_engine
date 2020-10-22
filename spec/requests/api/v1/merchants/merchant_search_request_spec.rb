require 'rails_helper'

describe 'Merchants Search Endpoints' do
  it "Single search by name fragment; case insensitive" do
    merchant = create(:merchant, name: 'Bobs Pawn Shop')
    4.times {create(:merchant)}

    value = "PaW"

    get "/api/v1/merchants/find?name=#{value}"

    expect(Merchant.all.count).to eq(5)
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    search_json = JSON.parse(response.body, symbolize_names: true)

    expect(search_json[:data][:id]).to eq(merchant.id.to_s)
    expect(search_json[:data][:type]).to eq('merchant')
    expect(search_json[:data][:attributes][:name]).to eq(merchant.name)
  end

  it "Multi search by name fragment; case insensitive" do
    merchant1 = create(:merchant, name: 'Bobs Pawn Shop')
    merchant2 = create(:merchant, name: 'Ricks Pawn Shop')
    3.times {create(:merchant)}

    value = 'PaW'

    get "/api/v1/merchants/find_all?name=#{value}"

    expect(Merchant.all.count).to eq(5)
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    search_json = JSON.parse(response.body, symbolize_names: true)
    expect(search_json[:data].count).to eq(2)
    expect(search_json[:data].first[:id]).to eq(merchant1.id.to_s)
    expect(search_json[:data].last[:id]).to eq(merchant2.id.to_s)
    expect(search_json[:data].first[:type]).to eq('merchant')
    expect(search_json[:data].last[:type]).to eq('merchant')
    expect(search_json[:data].first[:attributes][:name]).to eq(merchant1.name)
    expect(search_json[:data].last[:attributes][:name]).to eq(merchant2.name)
  end
end
