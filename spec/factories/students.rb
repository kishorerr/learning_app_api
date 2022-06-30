FactoryBot.define do
    factory :student do
      email {Faker::Internet.email}
    end
  end