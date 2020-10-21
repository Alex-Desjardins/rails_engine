require 'rails_helper'

describe 'Merchants REST Endpoints' do
  it 'can return all merchants' do
    create_list(:merchant, 5)

    get '/api/v1/merchants'
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(5)
    expect(merchants[:data].first).to have_key(:id)
    expect(merchants[:data].first).to have_key(:type)
    expect(merchants[:data].first).to have_key(:attributes)
    expect(merchants[:data].first[:attributes]).to have_key(:name)
  end

  it "can return a merchant" do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_json[:data][:id]).to eq(merchant.id.to_s)
    expect(merchant_json[:data]).to have_key(:id)
    expect(merchant_json[:data]).to have_key(:type)
    expect(merchant_json[:data]).to have_key(:attributes)
    expect(merchant_json[:data][:attributes]).to have_key(:name)
  end

  it "can create a merchant" do
    merchant_params = { name: "Wilderness Exchange" }
    headers = { "CONTENT_TYPE" => "application/json" }

    post "/api/v1/merchants", params: JSON.generate(merchant_params), headers: headers
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    merchant = Merchant.last
    expect(merchant.name).to eq(merchant_params[:name])

    merchant_json = JSON.parse(response.body, symbolize_names: true)
    expect(merchant_json[:data][:id]).to eq(merchant.id.to_s)
    expect(merchant_json[:data][:type]).to eq("merchant")
    expect(merchant_json[:data][:attributes][:name]).to eq(merchant_params[:name])
  end

  it "can update a merchant" do
    merchant = create(:merchant)
    merchant_params = { name: "Wilderness Exchange" }
    headers = { "CONTENT_TYPE" => "application/json" }
    original_merchant = Merchant.last

    put "/api/v1/merchants/#{merchant.id}", params: JSON.generate(merchant_params), headers: headers
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    merchant = Merchant.find(merchant.id)

    expect(merchant.name).to_not eq(original_merchant.name)
    expect(merchant.name).to eq(merchant_params[:name])

    merchant_json = JSON.parse(response.body, symbolize_names: true)
    expect(merchant_json[:data][:id]).to eq(merchant.id.to_s)
    expect(merchant_json[:data][:type]).to eq("merchant")
    expect(merchant_json[:data][:attributes][:name]).to eq(merchant_params[:name])
  end

  it "can destroy a merchant and its items" do
    merchant = create(:merchant)
    item1 = merchant.items.create(name: 'Bowling Ball', description: '10 pound ball', unit_price: 54.75)
    item2 = merchant.items.create(name: 'Basket Ball', description: 'High quality leather', unit_price: 22.00)

    expect(Merchant.count).to eq(1)
    expect(merchant.items.count).to eq(2)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(Merchant.count).to eq(0)

    expect(response).to be_successful

    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect{Item.find(item1.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect{Item.find(item2.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
