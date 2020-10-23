require 'rails_helper'

describe 'Business intelligence' do
  before :each do
    @m1, @m2, @m3, @m4, @m5, @m6 = create_list(:merchant, 6)
    # one item per merchant
    @it1 = create(:item, merchant: @m1)
    @it2 = create(:item, merchant: @m2)
    @it3 = create(:item, merchant: @m3)
    @it4 = create(:item, merchant: @m4)
    @it5 = create(:item, merchant: @m5)
    @it6 = create(:item, merchant: @m6)
    # one invoice for each merchant, status=shipped, also set the created_at
    @iv1 = create(:invoice, merchant: @m1, status: 'shipped', created_at: '2020-01-01T00:00:00 UTC')
    @iv2 = create(:invoice, merchant: @m2, status: 'shipped', created_at: '2020-02-02T00:00:00 UTC')
    @iv3 = create(:invoice, merchant: @m3, status: 'shipped', created_at: '2020-03-03T00:00:00 UTC')
    @iv4 = create(:invoice, merchant: @m4, status: 'shipped', created_at: '2020-04-04T00:00:00 UTC')
    @iv5 = create(:invoice, merchant: @m5, status: 'shipped', created_at: '2020-05-05T00:00:00 UTC')
    @iv6 = create(:invoice, merchant: @m6, status: 'packaged', created_at: '2020-06-06T00:00:00 UTC')
    # one invoice_item for each invoice, low quantity and price to high quantity and price
    @ii1 = create(:invoice_item, invoice: @iv1, item: @it1, quantity: 60, unit_price: 1) # rev: $60
    @ii2 = create(:invoice_item, invoice: @iv2, item: @it2, quantity: 55, unit_price: 2) # rev: $110
    @ii3 = create(:invoice_item, invoice: @iv3, item: @it3, quantity: 30, unit_price: 5) # rev: $150
    @ii4 = create(:invoice_item, invoice: @iv4, item: @it4, quantity: 40, unit_price: 7) # rev: $280
    @ii5 = create(:invoice_item, invoice: @iv5, item: @it5, quantity: 50, unit_price: 9) # rev: $450
    @ii6 = create(:invoice_item, invoice: @iv6, item: @it6, quantity: 60, unit_price: 11) # rev: $660
    # one transaction for each invoice which are result=success
    @t1 = create(:transaction, invoice: @iv1, result: 'success')
    @t2 = create(:transaction, invoice: @iv2, result: 'success')
    @t3 = create(:transaction, invoice: @iv3, result: 'success')
    @t4 = create(:transaction, invoice: @iv4, result: 'success')
    @t5 = create(:transaction, invoice: @iv5, result: 'success')
    @t6 = create(:transaction, invoice: @iv6, result: 'failed')
  end

  it 'can get merchants with most revenue' do
    top_3 = 3

    get "/api/v1/merchants/most_revenue?quantity=#{top_3}"
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:data].count).to eq(3)

    expect(json[:data].first[:attributes][:name]).to eq(@m5.name)
    expect(json[:data].first[:id]).to eq(@m5.id.to_s)

    expect(json[:data][1][:attributes][:name]).to eq(@m4.name)
    expect(json[:data][1][:id]).to eq(@m4.id.to_s)

    expect(json[:data].last[:attributes][:name]).to eq(@m3.name)
    expect(json[:data].last[:id]).to eq(@m3.id.to_s)
  end

  it 'can get merchants with most items sold' do
    top_3 = 3

    get "/api/v1/merchants/most_items?quantity=#{top_3}"
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:data].count).to eq(3)

    expect(json[:data].first[:attributes][:name]).to eq(@m1.name)
    expect(json[:data].first[:id]).to eq(@m1.id.to_s)

    expect(json[:data][1][:attributes][:name]).to eq(@m2.name)
    expect(json[:data][1][:id]).to eq(@m2.id.to_s)

    expect(json[:data].last[:attributes][:name]).to eq(@m5.name)
    expect(json[:data].last[:id]).to eq(@m5.id.to_s)
  end

  # it 'can get revenue for a merchant' do
  #   get "/api/v1/merchants/#{@m1.id}/revenue"
  #   json = JSON.parse(response.body, symbolize_names: true)
  #   expect(json.count).to eq(1)
  #   expect(json[:data][:id]).to eq(@m1.id.to_s)
  #   expect(json[:data].first[:attributes][:revenue]).to eq(60)
  #
  #   get "/api/v1/merchants/#{@m5.id}/revenue"
  #   json = JSON.parse(response.body, symbolize_names: true)
  #   expect(json.count).to eq(1)
  #   expect(json[:data][:id]).to eq(@m5.id.to_s)
  #   expect(json[:data].first[:attributes][:revenue]).to eq(450)
  # end
end
