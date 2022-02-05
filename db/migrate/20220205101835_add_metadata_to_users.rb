class AddMetadataToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :metadata, :json, default: {}
  end

  def down
    remove_column :users, :metadata
  end
end
