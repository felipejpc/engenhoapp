FactoryBot.define do
  factory :tag, class: Blog::Tag do
    sequence(:tag_name) { |n| "tag:#{n}" }
    sequence(:contentful_id) { |n| "id:#{n}" }
  end
end