class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items,through: :invoices, dependent: :destroy
  has_many :transactions,through: :invoices, dependent: :destroy

  def self.single_search_string(params)
    find_by("name ILIKE '%#{params.values.reduce.downcase}%'")
  end

  def self.multi_search_string(params)
    where("name ILIKE '%#{params.values.reduce.downcase}%'")
  end

  def self.most_revenue(count)
     joins(invoices: [:transactions, :invoice_items])
     .select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
     .where("transactions.result='success'")
     .group('merchants.id')
     .order('revenue DESC')
     .limit(count)
  end

  def self.most_items(count)
     joins(invoices: [:transactions, :invoice_items])
     .select("merchants.*, SUM(invoice_items.quantity) AS sold_items")
     .where("transactions.result='success'")
     .group('merchants.id')
     .order('sold_items DESC')
     .limit(count)
  end
end
