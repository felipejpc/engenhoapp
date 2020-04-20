FactoryBot.define do
  factory :post, :class => Blog::Post do
    sequence(:slug) { |n| "sample-slug-#{n}" }
    sequence(:contentful_id) { |n| "id:#{n}" }
    json { {"custom_json"=> {} } }
    association(:category)
  end
end
