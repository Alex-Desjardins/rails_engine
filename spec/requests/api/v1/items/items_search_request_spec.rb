require 'rails_helper'

describe 'Items Search Endpoints' do
  describe "Single Search" do
    it "By name fragment; case insensitive" do
      item = create(:item, name: 'Hydro Flask')
      4.times {create(:item)}

      value = "DrO f"

      get "/api/v1/items/find?name=#{value}"

      expect(Item.all.count).to eq(5)
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_json = JSON.parse(response.body, symbolize_names: true)

      expect(search_json[:data][:id]).to eq(item.id.to_s)
      expect(search_json[:data][:type]).to eq('item')
      expect(search_json[:data][:attributes][:name]).to eq(item.name)
    end

    it "By description fragment; case insensitive" do
      item = create(:item, name: 'Hydro Flask', description: 'Two liter capacity')
      4.times {create(:item)}

      value = "Wo LI"

      get "/api/v1/items/find?description=#{value}"

      expect(Item.all.count).to eq(5)
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_json = JSON.parse(response.body, symbolize_names: true)

      expect(search_json[:data][:id]).to eq(item.id.to_s)
      expect(search_json[:data][:type]).to eq('item')
      expect(search_json[:data][:attributes][:name]).to eq(item.name)
      expect(search_json[:data][:attributes][:description]).to eq(item.description)
    end

    it "By unit price" do
      item = create(:item, name: 'Hydro Flask', description: 'Two liter capacity', unit_price: 25.73)
      4.times {create(:item)}

      get "/api/v1/items/find?unit_price=#{item.unit_price}"

      expect(Item.all.count).to eq(5)
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_json = JSON.parse(response.body, symbolize_names: true)

      expect(search_json[:data][:id]).to eq(item.id.to_s)
      expect(search_json[:data][:type]).to eq('item')
      expect(search_json[:data][:attributes][:name]).to eq(item.name)
      expect(search_json[:data][:attributes][:description]).to eq(item.description)
      expect(search_json[:data][:attributes][:unit_price]).to eq(item.unit_price)
    end

    it "By merchant_id" do
      item = create(:item)
      4.times {create(:item)}

      get "/api/v1/items/find?merchant_id=#{item.merchant_id}"

      expect(Item.all.count).to eq(5)
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_json[:data][:id]).to eq(item.id.to_s)
      expect(search_json[:data][:type]).to eq('item')
      expect(search_json[:data][:attributes][:name]).to eq(item.name)
      expect(search_json[:data][:attributes][:description]).to eq(item.description)
      expect(search_json[:data][:attributes][:unit_price]).to eq(item.unit_price)
      expect(search_json[:data][:attributes][:merchant_id]).to eq(item.merchant_id)
    end
  end



  describe "Multi search" do
    it "By name fragment; case insensitive" do
      item1 = create(:item, name: 'Hydro Flask')
      item2 = create(:item, name: 'Hydro Rambler')
      3.times {create(:item)}
      not_inlcuded = Item.all.last

      value = 'YDro'

      get "/api/v1/items/find_all?name=#{value}"

      expect(Item.all.count).to eq(5)
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_json[:data].count).to eq(2)
      expect(search_json[:data].first[:id]).to eq(item1.id.to_s)
      expect(search_json[:data].last[:id]).to eq(item2.id.to_s)
      expect(search_json[:data].first[:type]).to eq('item')
      expect(search_json[:data].last[:type]).to eq('item')
      expect(search_json[:data].first[:attributes][:name]).to eq(item1.name)
      expect(search_json[:data].last[:attributes][:name]).to eq(item2.name)
      expect(search_json[:data].include?(not_inlcuded.id)).to eq(false)
    end

    it "By description fragment; case insensitive" do
      item1 = create(:item, name: 'Hydro Flask', description: 'Two liter capacity')
      item2 = create(:item, name: 'Hydro Rambler', description: 'Three liter capacity')
      3.times {create(:item)}
      not_inlcuded = Item.all.last

      value = 'Er CAP'

      get "/api/v1/items/find_all?description=#{value}"

      expect(Item.all.count).to eq(5)
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_json[:data].count).to eq(2)
      expect(search_json[:data].first[:id]).to eq(item1.id.to_s)
      expect(search_json[:data].last[:id]).to eq(item2.id.to_s)
      expect(search_json[:data].first[:type]).to eq('item')
      expect(search_json[:data].last[:type]).to eq('item')
      expect(search_json[:data].first[:attributes][:name]).to eq(item1.name)
      expect(search_json[:data].last[:attributes][:name]).to eq(item2.name)
      expect(search_json[:data].first[:attributes][:description]).to eq(item1.description)
      expect(search_json[:data].last[:attributes][:description]).to eq(item2.description)
      expect(search_json[:data].include?(not_inlcuded.id)).to eq(false)
    end

    it "By unit price" do
      item1 = create(:item, name: 'Hydro Flask', description: 'Two liter capacity', unit_price: 22.75)
      item2 = create(:item, name: 'Hydro Rambler', description: 'Three liter capacity', unit_price: 22.75)
      3.times {create(:item)}
      not_inlcuded = Item.all.last

      value = 22.75

      get "/api/v1/items/find_all?unit_price=#{value}"

      expect(Item.all.count).to eq(5)
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_json[:data].count).to eq(2)
      expect(search_json[:data].first[:id]).to eq(item1.id.to_s)
      expect(search_json[:data].last[:id]).to eq(item2.id.to_s)
      expect(search_json[:data].first[:type]).to eq('item')
      expect(search_json[:data].last[:type]).to eq('item')
      expect(search_json[:data].first[:attributes][:name]).to eq(item1.name)
      expect(search_json[:data].last[:attributes][:name]).to eq(item2.name)
      expect(search_json[:data].first[:attributes][:description]).to eq(item1.description)
      expect(search_json[:data].last[:attributes][:description]).to eq(item2.description)
      expect(search_json[:data].first[:attributes][:unit_price]).to eq(item1.unit_price)
      expect(search_json[:data].last[:attributes][:unit_price]).to eq(item2.unit_price)
      expect(search_json[:data].include?(not_inlcuded.id)).to eq(false)
    end

    it "By merchant_id" do
      merchant = create(:merchant)
      item1 = create(:item, merchant_id: merchant.id)
      item2 = create(:item, merchant_id: merchant.id)
      3.times {create(:item)}
      not_inlcuded = Item.all.last

      value = merchant.id

      get "/api/v1/items/find_all?merchant_id=#{value}"

      expect(Item.all.count).to eq(5)
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json")

      search_json = JSON.parse(response.body, symbolize_names: true)
      expect(search_json[:data].count).to eq(2)
      expect(search_json[:data].first[:id]).to eq(item1.id.to_s)
      expect(search_json[:data].last[:id]).to eq(item2.id.to_s)
      expect(search_json[:data].first[:type]).to eq('item')
      expect(search_json[:data].last[:type]).to eq('item')
      expect(search_json[:data].first[:attributes][:name]).to eq(item1.name)
      expect(search_json[:data].last[:attributes][:name]).to eq(item2.name)
      expect(search_json[:data].first[:attributes][:description]).to eq(item1.description)
      expect(search_json[:data].last[:attributes][:description]).to eq(item2.description)
      expect(search_json[:data].first[:attributes][:unit_price]).to eq(item1.unit_price)
      expect(search_json[:data].last[:attributes][:unit_price]).to eq(item2.unit_price)
      expect(search_json[:data].first[:attributes][:merchant_id]).to eq(item1.merchant_id)
      expect(search_json[:data].last[:attributes][:merchant_id]).to eq(item2.merchant_id)
      expect(search_json[:data].include?(not_inlcuded.id)).to eq(false)
    end
  end
end
