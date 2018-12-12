class Trade < ApplicationRecord
  belongs_to :user
  belongs_to :cryptocurrency

  validates :user_id, :cryptocurrency_id, :fiat_price_cents, :fiat_amount_cents, :cryptocurrency_amount, :transaction_type, presence: true
  monetize :fiat_price_cents, :fiat_amount_cents
  #                          0      1
  enum transaction_type: [:buy, :sell]

  def self.list_transaction_types
    self.transaction_types.keys.map { |k| k.humanize.downcase }
  end
end
