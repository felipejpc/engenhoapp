class ChangePostTagReferences < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts_tags, :tag_id, :string
    remove_column :posts_tags, :post_id, :string
    add_reference :posts_tags, :post, null: false, foreign_key: true
    add_reference :posts_tags, :tag, null: false, foreign_key: true
  end
end
