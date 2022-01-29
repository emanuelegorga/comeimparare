class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid, default: -> { "uuid_generate_v4()" } do |t|
      t.string :name

      t.string :email, null: false
      t.index :email

      t.string :password_digest

      t.string :avatar_url

      t.string :platform, default: 'local'
      t.index :platform

      t.boolean :is_admin, default: false
      t.index :is_admin

      t.timestamps
    end
  end
end
