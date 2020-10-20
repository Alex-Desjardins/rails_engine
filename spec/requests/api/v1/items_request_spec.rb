require 'rails_helper'

describe 'Items REST Endpoints' do
  it 'can return all items' do
    create_list(:item, 5)

    get '/api/v1/items'
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    items_json = JSON.parse(response.body, symbolize_names: true)

    expect(items_json[:data].count).to eq(5)
    expect(items_json[:data].first).to have_key(:id)
    expect(items_json[:data].first).to have_key(:type)
    expect(items_json[:data].first).to have_key(:attributes)
    expect(items_json[:data].first[:attributes]).to have_key(:name)
    expect(items_json[:data].first[:attributes]).to have_key(:description)
    expect(items_json[:data].first[:attributes]).to have_key(:unit_price)
    expect(items_json[:data].first[:attributes]).to have_key(:merchant_id)
  end

  it 'can return a item' do
    item = create(:item)

    get "/api/v1/items/#{item.id}"
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    item_json = JSON.parse(response.body, symbolize_names: true)

    expect(item_json[:data][:id]).to eq(item.id.to_s)
    expect(item_json[:data]).to have_key(:id)
    expect(item_json[:data]).to have_key(:type)
    expect(item_json[:data]).to have_key(:attributes)
    expect(item_json[:data][:attributes]).to have_key(:name)
  end

  it "can create a item" do
    merchant = create(:merchant)
    item_params = { name: "GriGri Belay Device", description: "Best belay device in town.", unit_price: 23.90, merchant_id: merchant.id}
    headers = { "CONTENT_TYPE" => "application/json" }

    post "/api/v1/items", params: JSON.generate(item_params), headers: headers
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    item = Item.last
    expect(item.name).to eq(item_params[:name])

    item_json = JSON.parse(response.body, symbolize_names: true)
    expect(item_json[:data][:id]).to eq(item.id.to_s)
    expect(item_json[:data][:type]).to eq("item")
    expect(item_json[:data][:attributes][:name]).to eq(item_params[:name])
    expect(item_json[:data][:attributes][:description]).to eq(item_params[:description])
    expect(item_json[:data][:attributes][:unit_price]).to eq(item_params[:unit_price])
    expect(item_json[:data][:attributes][:merchant_id]).to eq(item_params[:merchant_id])
  end

  it "can update a item" do
    item = create(:item)
    item_params = { name: "ATC Belay Device" }
    headers = { "CONTENT_TYPE" => "application/json" }
    original_item = Merchant.last

    put "/api/v1/items/#{item.id}", params: JSON.generate(item_params), headers: headers
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")

    updated_item = Item.find(item.id)

    expect(updated_item.name).to_not eq(original_item.name)
    expect(updated_item.name).to eq(item_params[:name])

    item_json = JSON.parse(response.body, symbolize_names: true)
    expect(item_json[:data][:id]).to eq(updated_item.id.to_s)
    expect(item_json[:data][:type]).to eq("item")
    expect(item_json[:data][:attributes][:name]).to eq(item_params[:name])
  end

  it "can destroy a merchant" do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(Item.count).to eq(0)
    expect(response).to be_successful

    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
