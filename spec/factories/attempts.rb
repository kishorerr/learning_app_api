FactoryBot.define do
    factory :attempt do
      score {Faker::Number.between(from: 1, to: 10)}
      attempted_at {Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)}
      finished_at {Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)}
    end
  end