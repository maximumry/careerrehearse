FactoryBot.define do
  factory :user do
    username              { Faker::Alphanumeric.alpha(number: 10) }
    email                 {Faker::Internet.email}
    password              {Faker::Internet.password(min_length: 16) + "ACD"}
    password_confirmation {password}
  end
end
