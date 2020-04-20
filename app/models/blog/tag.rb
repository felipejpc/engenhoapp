# frozen_string_literal: true

class Blog::Tag < ApplicationRecord
  has_and_belongs_to_many :posts

  validates_presence_of :tag_name, :contentful_id
  validates_uniqueness_of :tag_name, :contentful_id
end
