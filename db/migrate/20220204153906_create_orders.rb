class CreateOrders < ActiveRecord::Migration[7.0]
  def up
    create_table :orders, id: :uuid, default: -> { "uuid_generate_v4()" } do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.integer :total, default: 0
      t.text :courses, array: true, default: []
      t.string :payment_method
      t.datetime :paid_at
      t.json :metadata, default: {}

      t.timestamps
    end
  end

  def down
    drop_table :orders
  end
end
