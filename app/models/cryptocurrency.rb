class Cryptocurrency < ApplicationRecord
  include PgSearch
  has_many :portfolios
  has_many :trades

  validates :ticker_name, :ticker_code, uniqueness: true, presence: true

  pg_search_scope :search_by_ticker_name_and_ticker_code,
    against: [:ticker_name, :ticker_code],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end

# [@cryptocurrency.ticker_name][@cryptocurrency.ticker_code]
