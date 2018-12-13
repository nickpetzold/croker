class DashboardsController < ApplicationController
  before_action :top_five_traded, :latest_news, :top5_winners, :top5_losers
  before_action :set_portfolio, only: [:dashboard, :portfolio_overview]

  def dashboard
   @portfolio_overview = portfolio_overview
  end

  private

  def portfolio_overview
    # {"Bitcoin"=>{"BTC"=>3443.67}, "Ethereum"=>{"ETH"=>200.04}}
    live_prices = crypto_service.call_current_prices
    # ---- THIS IS WHERE WE CALCULATE THE CURRENT PRICE FOR EVERY
    # ---- CRYPTOCURRENCY OWNED BY THE USER
    portfolio_price_hash = {}
    portfolio_price_hash_of_hashes = {}

    @portfolios.each do |portfolio|
      portfolio_price_hash[portfolio.cryptocurrency.ticker_code] = live_prices[portfolio.cryptocurrency.ticker_name.capitalize][portfolio.cryptocurrency.ticker_code]
      # {"Bitcoin" => {"BTC"=>3443.67}, "Ethereum" => {"ETH"=>200.04}}
      portfolio_price_hash_of_hashes[portfolio.cryptocurrency.ticker_name] = portfolio_price_hash
    end

    # ---- THIS IS WHERE WE CALCULATE THE CURRENT VALUE HELD BY EVERY
    # ---- CRYPTOCURRENCY OWNED BY THE USER

    ind_price_crypto_hash = {}

    @portfolios.each do |portfolio|
      live_price_per_crypto = portfolio_price_hash_of_hashes[portfolio.cryptocurrency.ticker_name][portfolio.cryptocurrency.ticker_code]
      crypto_armound_held = portfolio.crypto_amount_held
      # this returns something like this {"XRP"=>0.2093e1, "XLM"=>0.521e3, "ADA"=>0.5798e0}
      ind_price_crypto_hash[portfolio.cryptocurrency.ticker_code] = live_price_per_crypto * crypto_armound_held
    end

    # ---- THIS IS WHERE WE CALCULATE THE CURRENT
    # ---- THE CURRENT PROFIT / LOSS

    profit_or_loss_array = []
    profit_or_loss_hash_of_arrays = {}

    @portfolios.each do |portfolio|
      portfolio.cryptocurrency.trades.buy.each do |trade|
        price_paid = trade.fiat_amount_cents
        price_now = portfolio_price_hash_of_hashes[trade.cryptocurrency.ticker_name][trade.cryptocurrency.ticker_code] * trade.cryptocurrency_amount
        profit_or_loss_array << price_now - price_paid
        profit_or_loss_hash_of_arrays[trade.cryptocurrency.ticker_name] = profit_or_loss_array
      end
      portfolio.cryptocurrency.trades.sell.each do |trade|
        price_paid = trade.fiat_amount_cents
        price_now = portfolio_price_hash_of_hashes[trade.cryptocurrency.ticker_name][trade.cryptocurrency.ticker_code] * trade.cryptocurrency_amount
        profit_or_loss_array << price_now - price_paid
        profit_or_loss_hash_of_arrays[trade.cryptocurrency.ticker_name] = profit_or_loss_array
      end
      # THIS RETURNS SOMETHING LIKE THE BELOW EXAMPLE
      # {"Ripple"=>[-0.999985055e5, -0.3988044e3, -0.11999994022e7, -0.3399487e7, -0.1999994246e6],
      # "Stellar"=>[-0.999985055e5, -0.3988044e3, -0.11999994022e7, -0.3399487e7, -0.1999994246e6],
      # "Cardano"=>[-0.999985055e5, -0.3988044e3, -0.11999994022e7, -0.3399487e7, -0.1999994246e6]}
    end
  end

  def top_five_traded
    # this returns an hash with the top5 most traded by volume
    # across all the different exchanges
    # Also, it comes sorted from the API
    # ex: {:Bitcoin=>"BTC", :Ethereum=>"ETH", :EOS=>"EOS", :XRP=>"XRP", :ZCash=>"ZEC"}
    @top_five = crypto_service.call_top5_traded
  end

  def latest_news
    # This returns an array of hashes with news articles
    @latest_news = crypto_service.call_latest_news
  end

  def top5_winners
    # this returns an hash like this
    # {"REP"=>8.108108108108116, "WAVES"=>6.535947712418292, "BNB"=>4.228486646884287, "BAT"=>2.183984116479158, "QTUM"=>1.8749999999999878}
    @top5_winners = crypto_service.call_top5_winners
  end

  def top5_losers
    # this returns an hash like this
    # {"DIG"=>-22.26890756302521, "BCH"=>-4.433786825878439, "ZEC"=>-4.110072323161049, "XLM"=>-3.729401561144838, "LSK"=>-3.361344537815129}
    @top5_losers = crypto_service.call_top5_losers
  end

  def crypto_service
    # API MEMOIZATION CODE
    @crypto_service ||= CryptoCompareService.new
  end

  def set_portfolio
    @portfolios = current_user.portfolios
  end
end
