class CreatePortfolios < ActiveRecord::Migration[5.2]
  def change
    create_table :portfolios do |t|
      t.references :user, foreign_key: true
      t.references :cryptocurrency, foreign_key: true
      t.decimal :amount_held, default: 0, null: false

      t.timestamps
    end
  end
end
