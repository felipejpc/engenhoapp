# frozen_string_literal: true

class Blog::Post < ApplicationRecord
  has_and_belongs_to_many :tags
  belongs_to :category

  validates_presence_of :slug, :contentful_id, :json
  validates :slug, :contentful_id, uniqueness: true
  validate :json_is_a_custom_json_format

  def increment_views(by=1)
    self.views ||= 0
    self.views += by
    save
  end

  private

  def json_is_a_custom_json_format
    unless json.nil?
      if json.keys != ["custom_json"]
        errors.add(:json, 'Must be a custom_json format. Use ContentfulCustomJson class to format json correctly')
      end
    end
  end
end
