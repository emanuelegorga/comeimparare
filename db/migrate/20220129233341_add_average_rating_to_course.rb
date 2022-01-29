class AddAverageRatingToCourse < ActiveRecord::Migration[7.0]
  def up
    add_column :courses, :average_rating, :float, default: 0.0, null: false
  end

  def down
    remove_column :courses, :average_rating
  end
end
