FactoryBot.define do
    factory :student_enroll do
      otp {Faker::Number.number(digits: 4)}
      otp_generated_at {Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)}
    end
  end