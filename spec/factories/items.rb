FactoryBot.define do
  factory :item do
    name {Faker::Coffee.blend_name}
    description {Faker::Coffee.notes}
    unit_price {Faker::Number.decimal(l_digits: 2)}
    merchant
    created_at {Faker::Date.between(from: '2010-01-01', to: '2020-01-01')}
    updated_at {Faker::Date.between(from: '2010-01-01', to: '2020-01-01')}
  end
end
