class Tag < ApplicationRecord
  self.primary_key = 'contentful_id'
  has_and_belongs_to_many :postsqq
end
