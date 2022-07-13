FactoryBot.define do
    factory :qn_response do
      selected_option {Faker::String.random(length: 1)}
      marked_for_review {Faker::Boolean.boolean}
    end
  end