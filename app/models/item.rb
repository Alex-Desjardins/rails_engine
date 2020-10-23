class Item < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :unit_price,
                        :merchant_id

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  def self.single_search_string(params)
    find_by("#{params.keys.reduce} ILIKE '%#{params.values.reduce.downcase}%'")
  end

  def self.single_search_integer(params)
    find_by("#{params.keys.reduce}": params.values.reduce.downcase)
  end

  def self.multi_search_string(params)
    where("#{params.keys.reduce} ILIKE '%#{params.values.reduce.downcase}%'")
  end

  def self.multi_search_integer(params)
    where("#{params.keys.reduce}": params.values.reduce.downcase)
  end
end
