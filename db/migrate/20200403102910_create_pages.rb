# frozen_string_literal: true

class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :blog_pages do |t|
      t.string :contentful_id
      t.string :title
      t.string :slug
      t.text :body

      t.timestamps
    end
    add_index :blog_pages, :slug, unique: true
    add_index :blog_pages, :contentful_id, unique: true
  end
end
