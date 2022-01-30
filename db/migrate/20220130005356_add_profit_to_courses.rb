class AddProfitToCourses < ActiveRecord::Migration[7.0]
  def up
    add_column :courses, :profit, :integer, default: 0, null: false
  end

  def down
    remove_column :courses, :profit
  end
end
