FactoryBot.define do
    factory :s_class do
      class_no {Faker::Number.between(from: 5, to: 12)}
    end
  end