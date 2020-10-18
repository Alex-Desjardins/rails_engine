FactoryBot.define do
  factory :invoice do
    association :customer_id
    association :merchant_id
    status {"shipped"}
    created_at {Faker::Date.between(from: '2010-01-01', to: '2020-01-01')}
    updated_at {Faker::Date.between(from: '2010-01-01', to: '2020-01-01')}
  end
end
