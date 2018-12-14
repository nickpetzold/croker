class DashboardsController < ApplicationController
  before_action :set_portfolio, only: [:dashboard, :portfolio_overview, :value_held, :profit_or_loss]

  def dashboard
    @portfolio_value = portfolio_value
    @number_of_coins = number_of_coins
    @number_of_trades = number_of_trades
    @profit_factor = profit_factor
    @portfolio_overview = portfolio_overview
    @value_held = value_held
    @profit_or_loss = profit_or_loss
    @top_five = top_five_traded
    @top5_winners = top5_winners
    @top5_losers = top5_losers
    @latest_news = latest_news
  end

  private


  def portfolio_value
    @portfolios.sum(:fiat_amount_cents)
  end

  def number_of_coins
    @portfolios.count
  end

  def number_of_trades
    current_user.trades.count
  end

  def profit_factor
    # TODO
  end

  def portfolio_overview
    # {"Bitcoin"=>{"BTC"=>3443.67}, "Ethereum"=>{"ETH"=>200.04}}
    live_prices = crypto_service.call_current_prices
    # ---- THIS IS WHERE WE CALCULATE THE CURRENT PRICE FOR EVERY
    # ---- CRYPTOCURRENCY OWNED BY THE USER
    portfolio_price_hash = {}
    @portfolios.each do |portfolio|
      live_price = live_prices[tname(portfolio)][tcode(portfolio)]
      # this will return an hash of hashes like this
      # {"Ripple"=>{"XRP"=>0.2997}, "Stellar"=>{"XLM"=>0.1036}, "Cardano"=>{"ADA"=>0.02926}, "Bitcoin"=>{"BTC"=>3318.46}}
      portfolio_price_hash[tname(portfolio)] = { tcode(portfolio) => live_price }
    end
    portfolio_price_hash
  end

  def value_held
    # ---- THIS IS WHERE WE CALCULATE THE CURRENT VALUE HELD BY EVERY
    # ---- CRYPTOCURRENCY OWNED BY THE USER
    ind_price_crypto_hash = {}
    @portfolios.each do |portfolio|
      live_price = @portfolio_overview[tname(portfolio)][tcode(portfolio)]
      crypto_amount = portfolio.crypto_amount_held
      # this returns something like this {"XRP"=>0.2093e1, "XLM"=>0.521e3, "ADA"=>0.5798e0}
      ind_price_crypto_hash[tcode(portfolio)] = live_price * crypto_amount
    end
    ind_price_crypto_hash
  end

  def profit_or_loss
    # ---- THIS IS WHERE WE CALCULATE THE CURRENT
    # ---- THE CURRENT PROFIT / LOSS

    profit_or_loss_array = []
    profit_or_loss_hash_of_arrays = {}

    @portfolios.each do |portfolio|
      portfolio.cryptocurrency.trades.buy.each do |trade|
        price_paid = trade.fiat_amount_cents
        price_now = @portfolio_overview[trade.cryptocurrency.ticker_name][trade.cryptocurrency.ticker_code] * trade.cryptocurrency_amount
        profit_or_loss_array << price_now - price_paid
        profit_or_loss_hash_of_arrays[trade.cryptocurrency.ticker_name] = profit_or_loss_array
      end
      portfolio.cryptocurrency.trades.sell.each do |trade|
        price_paid = trade.fiat_amount_cents
        price_now = @portfolio_overview[trade.cryptocurrency.ticker_name][trade.cryptocurrency.ticker_code] * trade.cryptocurrency_amount
        profit_or_loss_array << price_now - price_paid
        profit_or_loss_hash_of_arrays[trade.cryptocurrency.ticker_name] = profit_or_loss_array
      end
      # THIS RETURNS SOMETHING LIKE THE BELOW EXAMPLE
      # {"Ripple"=>[-0.999985055e5, -0.3988044e3, -0.11999994022e7, -0.3399487e7, -0.1999994246e6],
      # "Stellar"=>[-0.999985055e5, -0.3988044e3, -0.11999994022e7, -0.3399487e7, -0.1999994246e6],
      # "Cardano"=>[-0.999985055e5, -0.3988044e3, -0.11999994022e7, -0.3399487e7, -0.1999994246e6]}
    end
    profit_or_loss_hash_of_arrays
  end

  def top_five_traded
    # this returns an hash with the top5 most traded by volume
    # across all the different exchanges
    # Also, it comes sorted from the API
    # ex: {:Bitcoin=>"BTC", :Ethereum=>"ETH", :EOS=>"EOS", :XRP=>"XRP", :ZCash=>"ZEC"}
    crypto_service.call_top5_traded
  end


  def top5_winners
    # this returns an hash like this
    # {"REP"=>8.108108108108116, "WAVES"=>6.535947712418292, "BNB"=>4.228486646884287, "BAT"=>2.183984116479158, "QTUM"=>1.8749999999999878}
    crypto_service.call_top5_winners
  end

  def top5_losers
    # this returns an hash like this
    # {"DIG"=>-22.26890756302521, "BCH"=>-4.433786825878439, "ZEC"=>-4.110072323161049, "XLM"=>-3.729401561144838, "LSK"=>-3.361344537815129}
    crypto_service.call_top5_losers
  end

  def latest_news
    # This returns an array of hashes with news articles
    crypto_service.call_latest_news
  end

  def crypto_service
    # API MEMOIZATION CODE
    @crypto_service ||= CryptoCompareService.new
  end

  def set_portfolio
    @portfolios = current_user.portfolios
  end

  def tcode(portfolio)
    portfolio.cryptocurrency.ticker_code
  end

  def tname(portfolio)
    portfolio.cryptocurrency.ticker_name.capitalize
  end
end
