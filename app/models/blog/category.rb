# frozen_string_literal: true

class Blog::Category < ApplicationRecord
  has_many :posts
end
