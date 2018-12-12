class Trade < ApplicationRecord
  belongs_to :user
  belongs_to :cryptocurrency

  validates :user_id, :cryptocurrency_id, :usd_cents_amount, :usd_price_cents, :cryptocurrency_amount, :transaction_type, presence: true
  monetize :usd_price_cents, :usd_cents_amount
  #                          0      1
  enum transaction_type: [:buy, :sell]
end
