# frozen_string_literal: true

class Page < ApplicationRecord
  validates_presence_of :slug, :contentful_id, :json, :type
  validates_uniqueness_of :slug, :contentful_id
  validates_with ContentfulCustomJsonValidator
end
