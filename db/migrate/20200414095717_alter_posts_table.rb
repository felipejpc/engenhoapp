class AlterPostsTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :title, :string
    remove_column :posts, :description, :text
    remove_column :posts, :thumb_image, :string
    add_column :posts, :json, :jsonb, null: false, default: '{}'
  end
end
