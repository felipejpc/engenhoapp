FactoryBot.define do
  factory :category, class: Blog::Category do
    sequence(:name) { |n| "name-#{n}" }
    sequence(:contentful_id) { |n| "id:#{n}" }
  end
end
