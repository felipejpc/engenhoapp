class AddThumbImageToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :thumb_image, :string
  end
end
