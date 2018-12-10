class CreateCryptocurrencies < ActiveRecord::Migration[5.2]
  def change
    create_table :cryptocurrencies do |t|
      t.string :ticker_name
      t.string :ticker_code

      t.timestamps
    end
  end
end
