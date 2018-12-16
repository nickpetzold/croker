class DashboardsController < ApplicationController
  before_action :set_portfolio, only: [:dashboard, :portfolio_overview]

  def dashboard
    portfolio_value
    # Commented this out as it's now in the
    # portfolio_overview
    number_of_coins
    number_of_trades
    top_five_traded
    top5_winners
    top5_losers
    latest_news
    days_since_last_trade
  end

  private

  def portfolio_value
    portfolio_overview
    @portfolio_value = 0
    current_user.portfolios.each do |portfolio|
      crypto = portfolio.cryptocurrency
      @portfolio_value += portfolio.crypto_amount_held * @live_prices[crypto.ticker_name][crypto.ticker_code]
    end
    current_user.current_portfolio_value = @portfolio_value
    current_user.save!
  end

  def number_of_coins
    @number_of_coins = @portfolios.count
  end

  def number_of_trades
    @number_of_trades = current_user.trades.count
  end

  def days_since_last_trade
    if current_user.trades.empty?
      @days_since_last_trade = "N/A"
    else
      ts_now = Time.now.day
      ts_last = current_user.trades.last.date_of_trade.day
      @days_since_last_trade = ts_now - ts_last
    end
  end

  def portfolio_overview
    # {"Bitcoin"=>{"BTC"=>3443.67}, "Ethereum"=>{"ETH"=>200.04}}
    @live_prices = crypto_service.call_current_prices
    # ---- THIS IS WHERE WE CALCULATE THE CURRENT PRICE FOR EVERY
    # ---- CRYPTOCURRENCY OWNED BY THE USER
    portfolio_price_hash = {}
    @portfolios.each do |portfolio|
      live_price = @live_prices[tname(portfolio)][tcode(portfolio)]
      # this will return an hash of hashes like this
      # {"Ripple"=>{"XRP"=>0.2997}, "Stellar"=>{"XLM"=>0.1036}, "Cardano"=>{"ADA"=>0.02926}, "Bitcoin"=>{"BTC"=>3318.46}}
      portfolio_price_hash[tname(portfolio)] = { tcode(portfolio) => live_price }
    end
    @portfolio_overview = portfolio_price_hash
  end

  def top_five_traded
    # this returns an hash with the top5 most traded by volume
    # across all the different exchanges
    # Also, it comes sorted from the API
    # ex: {:Bitcoin=>"BTC", :Ethereum=>"ETH", :EOS=>"EOS", :XRP=>"XRP", :ZCash=>"ZEC"}
    @top_five_traded = crypto_service.call_top5_traded
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

  def latest_news
    # This returns an array of hashes with news articles
    @latest_news = crypto_service.call_latest_news
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
    # IF THIS STARTS BREAKING TRY OUT WITH .capitalize !!!
    portfolio.cryptocurrency.ticker_name
  end
end
