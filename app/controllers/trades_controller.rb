class TradesController < ApplicationController
  def index
    # this is an array of instances
    @cryptocurrencies = Cryptocurrency.all
    # this is an hash of hashes with current prices
    @live_prices = CryptoCompareService.new.call_current_prices
    @live_news = CryptoCompareService.new.call_latest_news
  end

  def show

  end

  def new

  end

  def create
  end
end
