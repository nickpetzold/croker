class Trade < ApplicationRecord
  belongs_to :user
  belongs_to :cryptocurrency

  validates :user_id, :cryptocurrency_id, :fiat_price_cents, :fiat_amount_cents, :cryptocurrency_amount, :transaction_type, presence: true
  monetize :usd_price_cents, :usd_cents_amount
  #                          0      1
  enum transaction_type: [:buy, :sell]
end
