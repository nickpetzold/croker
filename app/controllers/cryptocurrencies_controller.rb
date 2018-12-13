class CryptocurrenciesController < ApplicationController
  def index
    # this is an array of instances
    @cryptocurrencies = Cryptocurrency.all
    # this is an hash of hashes with current prices fetched from the api
    @live_prices = crypto_service.call_current_prices
    # this is an array of hashes with latest news fetched from the api
    @live_news = crypto_service.call_latest_news

    if params["query"].present?
      @cryptocurrencies = Cryptocurrency.search_by_ticker_name_and_ticker_code(params["query"])
    else
      @cryptocurrencies = Cryptocurrency.all
    end
      # @cryptocurrencies_search =

    # this condition takes care of showing the "show" when a cryptocurrency is selected
    if params[:crypto_id]
      @cryptocurrency = Cryptocurrency.find(params[:crypto_id])
      # @live_price = crypto_service.call_current_prices[@cryptocurrency.ticker_name][@cryptocurrency.ticker_code]

      # --------------TODO LATER------------------
      # CALL THE CHART ON THE SHOW
      # CALL THE USER BALANCE ON THE SHOWD
      # DISPLAY THE TIMEFRAME
    end
  end

  def call_chart
    @data = []
    @cryptocurrency = Cryptocurrency.find(params[:cryptocurrency_id])
    day_prices = crypto_service.call_historical_prices(@cryptocurrency.ticker_code, 'yearly')
    hour_prices = crypto_service.call_historical_prices(@cryptocurrency.ticker_code, 'hourly')
    minute_prices = crypto_service.call_historical_prices(@cryptocurrency.ticker_code, 'minutely')
    day_time = get_time_data('year')
    hour_time = get_time_data('hour')
    minute_time = get_time_data('minute')
    @data << day_time.zip(day_prices)
    @data << hour_time.last(721).zip(hour_prices.last(721))
    @data << hour_time.last(168).zip(hour_prices.last(168))
    @data << minute_time.last(1440).zip(minute_prices.last(1440))
  end

  def crypto_service
    # API MEMOIZATION CODE
    @crypto_service ||= CryptoCompareService.new
  end

  private

  def get_time_data(period)
    time = []
    case period
    when 'year'
      last_year = DateTime.now - 365
      365.times { |days| time << (last_year + days).strftime('%s').to_i * 1000 }
    when 'hour'
      last_month = DateTime.now - 30
      760.times { |hours| time << (last_month + ((1 / 24.0) * hours)).strftime('%s').to_i * 1000 }
    when 'minute'
      yesterday = DateTime.now - 1
      1440.times { |minutes| time << (yesterday + ((1 / 1440.0) * minutes)).strftime('%s').to_i * 1000 }
    else
      puts 'That is not a valid time period'
    end
    return time
  end
end
