class ChartsController < ApplicationController
  def show
    @cryptocurrency = Cryptocurrency.find(params[:cryptocurrency_id])
    days = (1..365).to_a
    prices = crypto_service.call_historical_prices(@cryptocurrency.ticker_code, days.last)
    @data = days.zip(prices).first(365)
  end

  private

  def crypto_service
    # API MEMOIZATION CODE
    @crypto_service ||= CryptoCompareService.new
  end
end
