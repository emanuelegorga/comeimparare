class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid, default: -> { "uuid_generate_v4()" } do |t|
      t.string :login, null: false
      t.index :login

      t.string :name, null: false

      t.string :url

      t.string :avatar_url

      t.string :provider, default: 'local'
      t.index :provider

      t.boolean :is_admin, default: false
      t.index :is_admin

      t.timestamps
    end
  end
end
