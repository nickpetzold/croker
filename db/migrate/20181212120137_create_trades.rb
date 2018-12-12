class CreateTrades < ActiveRecord::Migration[5.2]
  def change
    create_table :trades do |t|
      t.integer :transaction_type
      t.jsonb :payment
      t.references :user, foreign_key: true
      t.references :cryptocurrency, foreign_key: true
      t.monetize :usd_price, currency: { present: false }
      t.monetize :usd_amount, currency: { present: false }
      t.decimal :cryptocurrency_amount

      t.timestamps
    end
  end
end
