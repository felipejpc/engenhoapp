# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :contentful_id
      t.string :name

      t.timestamps
    end
    add_index :categories, :contentful_id
  end
end
