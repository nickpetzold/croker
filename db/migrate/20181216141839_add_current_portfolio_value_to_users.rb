class AddCurrentPortfolioValueToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :current_portfolio_value, :integer, default: 0
    remove_column :users, :country
  end
end
