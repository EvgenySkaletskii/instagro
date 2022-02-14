FactoryBot.define do
  factory :user do
    email { "test.user@example.com" }
    full_name { "Test User" }
    about { "I like RoR and RSpec" }
    password { "123123123" }
    password_confirmation { password }

    trait :manager do
      email { "manager.user@example.com" }
      role { 1 }
    end

    trait :admin do
      email { "admin.user@example.com" }
      role { 2 }
    end

    factory :manager, traits: [:manager]
    factory :admin, traits: [:admin]
  end
end
