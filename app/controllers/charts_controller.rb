class ChartsController < ApplicationController
  def show
    @cryptocurrency = Cryptocurrency.find(params[:cryptocurrency_id])
    days = (1..1000).to_a
    # days = ("2017-12-01", "2018-02-16").to_a
    # days = ["2017-12", "2018-12"]

    prices = crypto_service.call_historical_prices(@cryptocurrency.ticker_code, days.last)
    @data = days.zip(prices).first(1000)
    # @data = days.zip(prices).first()

  end

  private

  def crypto_service
    # API MEMOIZATION CODE
    @crypto_service ||= CryptoCompareService.new
  end
end
