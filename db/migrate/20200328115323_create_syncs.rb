class CreateSyncs < ActiveRecord::Migration[6.0]
  def change
    create_table :syncs do |t|
      t.string :content_type
      t.string :sync_type
      t.string :next_sync_url

      t.timestamps
    end
  end
end
