class Blog::Category < ApplicationRecord
  has_many :posts
end
