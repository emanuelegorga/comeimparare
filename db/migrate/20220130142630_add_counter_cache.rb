class AddCounterCache < ActiveRecord::Migration[7.0]
  def up
    add_column :courses, :joins_count, :integer, null: false, default: 0
    add_column :courses, :lectures_count, :integer, null: false, default: 0

    add_column :users, :courses_count, :integer, null: false, default: 0
    add_column :users, :joins_count, :integer, null: false, default: 0
    add_column :users, :progress_tracks_count, :integer, null: false, default: 0
    add_column :users, :remarks_count, :integer, null: false, default: 0
    add_column :users, :sign_in_count, :integer, null: false, default: 0

    add_column :lectures, :remarks_count, :integer, null: false, default: 0
    add_column :lectures, :progress_tracks_count, :integer, null: false, default: 0
  end

  def down
    remove_column :courses, :joins_count
    remove_column :courses, :lectures_count

    remove_column :users, :courses_count
    remove_column :users, :joins_count
    remove_column :users, :progress_tracks_count
    remove_column :users, :remarks_count
    remove_column :users, :sign_in_count

    remove_column :lectures, :remarks_count
    remove_column :lectures, :progress_tracks_count
  end
end
