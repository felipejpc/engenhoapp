class AddContentIdIndexToPosts < ActiveRecord::Migration[6.0]
  def change
    remove_index :posts, :content_id
    add_index :posts, :content_id, unique: true
  end
end
