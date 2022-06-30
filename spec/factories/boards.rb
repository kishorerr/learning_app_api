FactoryBot.define do
    factory :board do
      b_name {Faker::Lorem.word}
      b_desc {Faker::Lorem.sentence}
    end
  end