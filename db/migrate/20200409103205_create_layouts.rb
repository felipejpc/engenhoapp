class CreateLayouts < ActiveRecord::Migration[6.0]
  def change
    create_table :layouts do |t|
      t.string :name, null: false
      t.string :contentful_id, null: false
      t.jsonb :json, null: false, default: '{}'

      t.timestamps
    end
    add_index :layouts, :name
    add_index :layouts, :contentful_id
  end
end
