class AlterPagesTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :pages, :title, :string
    remove_column :pages, :body, :text
    add_column :pages, :json, :jsonb, null: false, default: '{}'
  end
end
