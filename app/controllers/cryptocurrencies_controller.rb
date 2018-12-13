class CryptocurrenciesController < ApplicationController
  def index
    # this is an array of instances
    @cryptocurrencies = Cryptocurrency.all
    # this is an hash of hashes with current prices fetched from the api
    @live_prices = crypto_service.call_current_prices
    # this is an array of hashes with latest news fetched from the api
    @live_news = crypto_service.call_latest_news
  end

  def show
    @cryptocurrency = Cryptocurrency.find(params[:id])
    @live_price = crypto_service.call_current_prices[@cryptocurrency.ticker_name][@cryptocurrency.ticker_code]

    # --------------TODO LATER------------------
    # CALL THE CHART ON THE SHOW
    # CALL THE USER BALANCE ON THE SHOW
    # DISPLAY THE TIMEFRAME

  end

  def call_chart
    @cryptocurrency = Cryptocurrency.find(params[:cryptocurrency_id])
    days = (0..364).to_a.reverse
    dates = days.map { |x| (DateTime.now - x).strftime('%s').to_i * 1000 }
    prices = crypto_service.call_historical_prices(@cryptocurrency.ticker_code, days.first)
    @data = dates.zip(prices).first(365)
  end

  def crypto_service
    # API MEMOIZATION CODE
    @crypto_service ||= CryptoCompareService.new
  end
end
