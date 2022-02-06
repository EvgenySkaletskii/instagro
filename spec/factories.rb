FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    first_name { "Example" }
    last_name { "User" }
    sequence(:nickname) { |n| "tester##{n}" }
    about { "some text" }
    password { "123123123" }
    password_confirmation { password }
  end
end
