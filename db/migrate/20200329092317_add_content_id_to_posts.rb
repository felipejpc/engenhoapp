# frozen_string_literal: true

class AddContentIdToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :content_id, :string
    add_index :posts, :content_id
  end
end
