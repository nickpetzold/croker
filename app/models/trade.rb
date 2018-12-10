class Trade < ApplicationRecord
  belongs_to :user
  belongs_to :cryptocurrency

  validates :user_id, :cryptocurrency_id, :usd_cents_value, :usd_cents_rate, :cryptocurrency_value, :transaction_type, presence: true
  #               0      1
  enum state: [:buy, :sell]
end
