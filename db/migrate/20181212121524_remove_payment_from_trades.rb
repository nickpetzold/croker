class RemovePaymentFromTrades < ActiveRecord::Migration[5.2]
  def change
    remove_column :trades, :payment
  end
end
