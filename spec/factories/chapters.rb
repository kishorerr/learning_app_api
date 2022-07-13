FactoryBot.define do
    factory :chapter do
      c_name {Faker::Lorem.word}
      pdf_no {Faker::Number.between(from: 1, to: 10)}
      video_no {Faker::Number.between(from: 1, to: 10)}
    end
  end