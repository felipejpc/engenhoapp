# frozen_string_literal: true

class Blog::Tag < ApplicationRecord
  has_and_belongs_to_many :posts
end
