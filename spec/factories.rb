FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:full_name) { |n| "Example User##{n}" }
    about { "some text" }
    password { "123123123" }
    password_confirmation { password }
  end
end
