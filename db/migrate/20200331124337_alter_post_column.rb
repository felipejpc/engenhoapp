# frozen_string_literal: true

class AlterPostColumn < ActiveRecord::Migration[6.0]
  def change
    remove_index :posts, :content_id
    remove_column :posts, :content_id, :string
    add_column :posts, :contentful_id, :string
    add_index :posts, :contentful_id, unique: true
  end
end
