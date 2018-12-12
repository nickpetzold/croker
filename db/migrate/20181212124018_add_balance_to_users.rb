class AddBalanceToUsers < ActiveRecord::Migration[5.2]
  def change
    add_monetize :users, :fiat_balance, currency: { present: false }
  end
end
