class Portfolio < ApplicationRecord
  belongs_to :user
  belongs_to :cryptocurrency

  validates :crypto_amount_held, numericality: { greater_than_or_equal_to: 0 }, presence: true

  default_scope { order(fiat_amount_cents: :desc) }
end
