class TopUp < ApplicationRecord
  belongs_to :user

  validates :user, :fiat_amount_cents, :state, :transaction_type, :date_of_top_up, presence: true
  monetize :fiat_amount_cents

  enum transaction_type: [:top_up, :withdrawal]
end
