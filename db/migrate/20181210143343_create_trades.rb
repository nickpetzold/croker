class CreateTrades < ActiveRecord::Migration[5.2]
  def change
    create_table :trades do |t|
      t.references :user, foreign_key: true
      t.references :cryptocurrency, foreign_key: true
      t.integer :usd_cents_rate
      t.integer :usd_cents_value
      t.decimal :cryptocurrency_value
      t.integer :transaction_type, null: false

      t.timestamps
    end
  end
end
