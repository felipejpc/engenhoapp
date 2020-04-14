class AddIndexToTags < ActiveRecord::Migration[6.0]
  def change
    add_index :tags, :tag_name, unique: true
  end
end
