class AddSummaryToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :summary, :text
  end
end
