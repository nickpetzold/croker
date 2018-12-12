class CreateTopUps < ActiveRecord::Migration[5.2]
  def change
    create_table :top_ups do |t|
      t.references :user, foreign_key: true
      t.monetize :fiat_amount, currency: { present: false }
      t.jsonb :payment
      t.integer :transaction_type
      t.datetime :date_of_top_up

      t.timestamps
    end
  end
end
