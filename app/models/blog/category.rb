# frozen_string_literal: true

class Blog::Category < ApplicationRecord
  has_many :posts

  validates_presence_of :name, :contentful_id
  validates_uniqueness_of :contentful_id
end
