# frozen_string_literal: true

class AddCategoryRefToPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :category, null: false, foreign_key: true
  end
end
