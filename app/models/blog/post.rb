class Blog::Post < ApplicationRecord
  has_and_belongs_to_many :tags
  belongs_to :category

  def increment_views(by = 1)
    self.views ||= 0
    self.views += by
    self.save
  end
end
