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

  def crypto_service
    # API MEMOIZATION CODE
    @crypto_service ||= CryptoCompareService.new
  end
end
