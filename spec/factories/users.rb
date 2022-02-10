FactoryBot.define do
  factory :user do
    email { "test.user@example.com" }
    full_name { "Test User" }
    about { "I like RoR and RSpec" }
    password { "123123123" }
    password_confirmation { password }
  end
end
