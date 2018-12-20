class CryptocurrenciesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    # this is an array of instances
    @cryptocurrencies = Cryptocurrency.all
    @value_held_hash = Hash.new(0)
    @cryptocurrencies.each do |crypto|
      if Portfolio.find_by(cryptocurrency: crypto, user: current_user)
        @value_held_hash[crypto.ticker_code] += Portfolio.find_by(cryptocurrency: crypto, user: current_user).crypto_amount_held
      end
    end
    # this is an hash of hashes with current prices fetched from the api
    @live_prices = crypto_service.call_current_prices

    if params["query"].present?
      @cryptocurrencies = Cryptocurrency.search_by_ticker_name_and_ticker_code(params["query"])
    else
      @cryptocurrencies = Cryptocurrency.all
    end
    # this condition takes care of showing the "show" when a cryptocurrency is selected
    if params[:crypto_id]
      @cryptocurrency = Cryptocurrency.find(params[:crypto_id])
      # THIS IS HARD CODED DONT FORGET TO REPLACE IT
      @latest_price = 2000
    end
    @crypto_autocomplete = Cryptocurrency.pluck(:ticker_name).sort
  end

  def chart
    @cryptocurrency = Cryptocurrency.find(params[:id])
    timeframe = params[:timeframe]
    tcode = @cryptocurrency.ticker_code
    @chart = []
    if timeframe == 'daily'
      @chart << chart_service.yearly_chart(tcode, timeframe)
    elsif timeframe == 'hourly'
      @chart << chart_service.monthly_chart(tcode, timeframe)
    elsif timeframe == 'hourly'
      @chart << chart_service.weekly_chart(tcode, timeframe)
    elsif timeframe == 'minutely'
      @chart << chart_service.daily_chart(tcode, timeframe)
    end
  end

  private

  def chart_service
    @chart_service ||= BuildChartService.new
  end

  def crypto_service
    # API MEMOIZATION CODE
    @crypto_service ||= CryptoCompareService.new
  end
end
