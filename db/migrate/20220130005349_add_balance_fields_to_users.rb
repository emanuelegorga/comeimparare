class AddBalanceFieldsToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :balance, :integer, default: 0, null: false
    add_column :users, :course_profit, :integer, default: 0, null: false
    add_column :users, :join_costs, :integer, default: 0, null: false
  end

  def down
    remove_column :users, :balance
    remove_column :users, :course_profit
    remove_column :users, :join_costs
  end
end
