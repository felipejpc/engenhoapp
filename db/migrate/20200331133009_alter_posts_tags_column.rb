class AlterPostsTagsColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts_tags, :post_id, :string
    add_column :posts_tags, :post_contentful_id, :string
    add_index :posts_tags, :post_contentful_id
    remove_column :posts_tags, :tag_id, :string
    add_column :posts_tags, :tag_contentful_id, :string
    add_index :posts_tags, :tag_contentful_id
  end
end
