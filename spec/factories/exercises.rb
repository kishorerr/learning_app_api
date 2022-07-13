FactoryBot.define do
    factory :exercise do
      title {Faker::Game.title}
      duration {Faker::Number.digit}
      qn_no {Faker::Number.between(from: 1, to: 10)}
      instructions {Faker::Lorem.sentence}
    end
  end