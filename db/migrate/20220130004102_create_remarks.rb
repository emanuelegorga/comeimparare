class CreateRemarks < ActiveRecord::Migration[7.0]
  def up
    create_table :remarks, id: :uuid, default: -> { "uuid_generate_v4()" } do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :lecture, null: false, foreign_key: true, type: :uuid
      t.text :content

      t.timestamps
    end
  end

  def down
    drop_table :remarks
  end
end
