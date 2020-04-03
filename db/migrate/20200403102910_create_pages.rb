class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.string :contentful_id
      t.string :title
      t.string :slug
      t.text :body

      t.timestamps
    end
    add_index :pages, :slug, unique: true
    add_index :pages, :contentful_id, unique: true
  end
end
