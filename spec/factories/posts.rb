FactoryBot.define do
  factory :post do
    sequence(:slug) { |n| "sample-slug-#{n}" }
  end
end
