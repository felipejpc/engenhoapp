# frozen_string_literal: true

class Blog::Post < ApplicationRecord
  has_and_belongs_to_many :tags
  belongs_to :category

  validates_presence_of :slug, :contentful_id, :json
  validates :slug, :contentful_id, uniqueness: true
  validates_with ContentfulCustomJsonValidator

  def increment_views(by=1)
    self.views ||= 0
    self.views += by
    save
  end
end
