class AddUserToCourses < ActiveRecord::Migration[7.0]
  def change
    add_reference :courses, :user, null: false, foreign_key: true, type: :uuid
  end
end
