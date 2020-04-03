class CreateUniqueIndexOnTagsAndCategories < ActiveRecord::Migration[6.0]
  def change
    remove_index :tags, :contentful_id
    remove_index :categories, :contentful_id
    add_index :tags, :contentful_id, unique: true
    add_index :categories, :contentful_id, unique: true
  end
end
