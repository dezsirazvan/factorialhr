FactoryBot.define do
  factory :metric do
    name { Faker::Name.first_name }
    value { Faker::Number.between(1, 1000)  }
  end
end
