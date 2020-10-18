FactoryBot.define do
  factory :customer do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    created_at {Faker::Date.between(from: '2010-01-01', to: '2020-01-01')}
    updated_at {Faker::Date.between(from: '2010-01-01', to: '2020-01-01')}
  end
end
