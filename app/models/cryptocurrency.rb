class Cryptocurrency < ApplicationRecord
  has_many :portfolios
  has_many :trades

  validates :ticker_name, :ticker_code, uniqueness: true, presence: true
end
