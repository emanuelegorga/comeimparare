class CreateLectures < ActiveRecord::Migration[7.0]
  def up
    create_table :lectures, id: :uuid, default: -> { "uuid_generate_v4()" } do |t|
      t.string :title
      t.text :content
      t.references :course, null: false, foreign_key: true, type: :uuid, index: true

      t.timestamps
    end
  end

  def down
    drop_table :lectures
  end
end
