FactoryBot.define do
  factory :invoice_item do
    association :item_id
    association :invoice_id
    quantity {Faker::Number.number(digits: 1)}
    unit_price {Faker::Number.decimal(l_digits: 2)}
    created_at {Faker::Date.between(from: '2010-01-01', to: '2020-01-01')}
    updated_at {Faker::Date.between(from: '2010-01-01', to: '2020-01-01')}
  end
end
