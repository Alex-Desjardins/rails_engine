require 'csv'

Customer.destroy_all
customers_file_path = "./db/csv_data/customers.csv"
CSV.foreach(customers_file_path, :headers => :true, header_converters: :symbol) do |row|
 Customer.create!( {
    id: row[:id],
    first_name: row[:first_name],
    last_name: row[:last_name],
    created_at: row[:created_at],
    updated_at: row[:updated_at]
  } )
end

Merchant.destroy_all
merchants_file_path = "./db/csv_data/merchants.csv"
CSV.foreach(merchants_file_path, :headers => :true, header_converters: :symbol) do |row|
 Merchant.create!( {
    id: row[:id],
    name: row[:name],
    created_at: row[:created_at],
    updated_at: row[:updated_at]
  } )
end

Item.destroy_all
items_file_path = "./db/csv_data/items.csv"
CSV.foreach(items_file_path, :headers => :true, header_converters: :symbol) do |row|
 Item.create!( {
    id: row[:id],
    name: row[:name],
    description: row[:description],
    unit_price: row[:unit_price],
    merchant_id: row[:merchant_id],
    created_at: row[:created_at],
    updated_at: row[:updated_at]
  } )
end

Invoice.destroy_all
invoices_file_path = "./db/csv_data/invoices.csv"
CSV.foreach(invoices_file_path, :headers => :true, header_converters: :symbol) do |row|
 Invoice.create!( {
    id: row[:id],
    customer_id: row[:customer_id],
    merchant_id: row[:merchant_id],
    status: row[:status],
    created_at: row[:created_at],
    updated_at: row[:updated_at]
  } )
end

require "pry"; binding.pry
