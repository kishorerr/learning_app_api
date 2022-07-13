FactoryBot.define do
    factory :student do
      username {"kishore"}
      ph_no {Faker::PhoneNumber.phone_number}
      dob {Faker::Date.between(from: '2014-09-23', to: '2014-09-25')}
      email {"cheems@gmail.com"}
      password {"1234567"}
    end
  end