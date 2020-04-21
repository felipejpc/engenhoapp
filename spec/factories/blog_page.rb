FactoryBot.define do
  factory :blog_page, :class => Blog::BlogPage do
    sequence(:slug) { |n| "sample-slug-#{n}" }
    sequence(:contentful_id) { |n| "id:#{n}" }
    json { {"custom_json"=> {} } }
    type { "BlogPage" }
  end
end