FactoryBot.define do
    factory :question do
      qn_no {Faker::Number.between(from: 1, to: 10)}
      question {Faker::Lorem.sentence}
      duration {Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)}
      solution {Faker::Lorem.sentence}
    end
  end