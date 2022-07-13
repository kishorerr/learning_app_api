FactoryBot.define do
    factory :option do
      option_name {"A"}
      option {Faker::Lorem.sentence}
      opt_status {"correct"}
    end
  end