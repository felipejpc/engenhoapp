# frozen_string_literal: true

class RenameSyncNextSyncUrlToSyncToken < ActiveRecord::Migration[6.0]
  def change
    change_table :syncs do |t|
      t.rename :next_sync_url, :sync_token
    end
  end
end
