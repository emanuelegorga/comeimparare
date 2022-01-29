class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses, id: :uuid, default: -> { "uuid_generate_v4()" } do |t|
      t.string :title
      t.string :description

      t.integer :difficulty, default: '0', null: false
      t.index :difficulty

      t.integer :language, default: '0', null: false
      t.index :language

      t.integer :price, default: '0', null: false

      t.jsonb :metadata, default: {}

      t.timestamps null: false
    end
  end
end