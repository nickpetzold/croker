class AddFiatAmountCentsToPortfolios < ActiveRecord::Migration[5.2]
  def change
    add_monetize :portfolios, :fiat_amount, currency: { present: false }
  end
end
