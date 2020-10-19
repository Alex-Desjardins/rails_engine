class Invoice < ApplicationRecord
  validates_presence_of :customer_id,
                        :merchant_id,
                        :status

  belongs_to :merchant
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
end
