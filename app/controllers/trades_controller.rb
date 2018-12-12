class TradesController < ApplicationController
  def new
    # can create new trades
    # fetch information from forms rendered in html
    # raise
    @cryptocurrency = Cryptocurrency.find(params[:cryptocurrency_id])
    @trade = Trade.new
  end

  def create
    @cryptocurrency = Cryptocurrency.find(params[:cryptocurrency_id])
    @trade = Trade.new(trade_params)
    @trade.user = current_user
    @trade.cryptocurrency = @cryptocurrency
    if @trade.save
      redirect_to cryptocurrencies_path
    else
      render :new
    end
  end

  def trade_params
    params.require(:trade).permit(:fiat_price_cents, :fiat_amount_cents, :cryptocurrency_amount, :transaction_type, :date_of_trade)
  end

  def crypto_service
    # API MEMOIZATION CODE
    @crypto_service ||= CryptoCompareService.new
  end
end
