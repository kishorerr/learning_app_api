FactoryBot.define do
    factory :content do
      content {'video'}
      link {Faker::Internet.url}
    end
  end