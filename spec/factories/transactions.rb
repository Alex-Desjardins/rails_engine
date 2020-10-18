FactoryBot.define do
  factory :transaction do
    association :invoice_id
    credit_card_number {Faker::Number.number(digits: 16)}
    result {'success'}
    created_at {Faker::Date.between(from: '2010-01-01', to: '2020-01-01')}
    updated_at {Faker::Date.between(from: '2010-01-01', to: '2020-01-01')}
  end
end
