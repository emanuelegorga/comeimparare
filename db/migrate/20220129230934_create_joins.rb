class CreateJoins < ActiveRecord::Migration[7.0]
  def up
    create_table :joins, id: :uuid, default: -> { "uuid_generate_v4()" } do |t|
      t.references :course, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.integer :rating
      t.text :review
      t.integer :price

      t.timestamps
    end
  end

  def down
    drop_table :joins
  end
end
