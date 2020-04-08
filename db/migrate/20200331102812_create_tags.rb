# frozen_string_literal: true

class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :contentful_id
      t.string :tag_name

      t.timestamps
    end
    add_index :tags, :contentful_id

    create_join_table :posts, :tags, table_name: :posts_tags do |t|
      t.index :post_id
      t.index :tag_id
    end
  end
end
