class AddAcceptAndPublishToCourse < ActiveRecord::Migration[7.0]
  def up
    add_column :courses, :accepted, :boolean
    add_column :courses, :published, :boolean, default: false
  end

  def down
    remove_column :courses, :accepted
    remove_column :courses, :published
  end
end
