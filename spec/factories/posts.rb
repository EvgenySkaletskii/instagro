FactoryBot.define do
  factory :post do
    user
    content { "Some post content" }
    created_at { Time.zone.now }
  end
end
