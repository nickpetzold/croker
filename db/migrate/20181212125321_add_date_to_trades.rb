class AddDateToTrades < ActiveRecord::Migration[5.2]
  def change
    add_column :trades, :date_of_trade, :datetime
  end
end
