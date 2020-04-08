# frozen_string_literal: true

class AddTypeToPages < ActiveRecord::Migration[6.0]
  def change
    add_column :blog_pages, :type, :string
    add_index :blog_pages, :type
  end
end
