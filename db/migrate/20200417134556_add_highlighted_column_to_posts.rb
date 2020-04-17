class AddHighlightedColumnToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :highlighted, :boolean, default: false
    add_index :posts, :highlighted
  end
end
