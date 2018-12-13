class TradesController < ApplicationController
  def new
    @cryptocurrency = Cryptocurrency.find(params[:cryptocurrency_id])
    @trade = Trade.new
  end

  def create
    # get the cryptocurrency
    @cryptocurrency = Cryptocurrency.find(params[:cryptocurrency_id])
    # create a new trade instance with private trade params
    @trade = Trade.new(trade_params)
    # assign this trade to the current user logged in
    @trade.user = current_user
    # assign this trade to the cryptocurrency associated
    @trade.cryptocurrency = @cryptocurrency
    # call the buy or sell private method
    buy_or_sell
  end

  private

  def buy_trade
    # avaluate if user has enough USD balance to buy the cryptocurrency
    if current_user.fiat_balance_cents >= @trade.fiat_amount_cents
      # if user has enough balance, verify if he entered all the required fields in the form
      if @trade.save
        # if the user entered all the required fields in the form
        # update his USD balance by subtracting the trade total amount
        current_user.fiat_balance_cents -= @trade.fiat_amount_cents
        # assign portfolio to user
        user_portfolio = check_portfolio
        # create or update the instance of portfolio with the cryptocurrency bought
        user_portfolio.crypto_amount_held += @trade.cryptocurrency_amount
        # save changes to portfolio
        user_portfolio.save
        # save current_user and redirect to dashboard or cryptocurrencies path
        current_user.save
        # redirect to dashboard path after successful buy trade
        redirect_to dashboard_path
      else
        # render new form if user didnt enter all the required fields in the form
        render :new
      end
    else
      # if user doesn't have enough balance redirect to new pop up to recharge !!!!
      redirect_to new_top_up_path, :alert => "NOT ENOUGH USD BALANCE" # becase user doesnt have enough balance
    end
  end

  def sell_trade
    # TODO
    # CHANGE THIS METHOD SO IT FETCHES USER PORTFOLIO BY CRYPTO
    # PORTFOLIO CONTROLLER HAS TO BE BUILT FIRST IN ORDER
    # FOR THIS TO WORK AS IT SHOULD.
    # FOR NOW JUST LET IT BE
    if user_crypto_balance?
      if @trade.save
        current_user.fiat_balance_cents += @trade.fiat_amount_cents
        user_portfolio = check_portfolio
        user_portfolio.crypto_amount_held -= @trade.cryptocurrency_amount
        user_portfolio.save
        current_user.save
        redirect_to dashboard_path
      else
        render :new
      end
    else
      redirect_to cryptocurrencies_path, :alert => "NOT ENOUGH #{@trade.cryptocurrency.ticker_name} BALANCE" # becase user doesnt have enough balance
    end
  end

  def user_crypto_balance?
    amount_bought = 0
    current_user.trades.buy.where(cryptocurrency_id: @cryptocurrency).each do |amount|
      amount_bought += amount.cryptocurrency_amount
    end

    amount_sold = 0
    current_user.trades.sell.where(cryptocurrency_id: @cryptocurrency).each do |amount|
      amount_sold += amount.cryptocurrency_amount
    end
    amount_bought > amount_sold
  end

  def buy_or_sell
    if @trade.buy?
      buy_trade
    else
      sell_trade
    end
  end

  def check_portfolio
    Portfolio.where(cryptocurrency_id: @cryptocurrency, user_id: current_user).first_or_create
  end

  def trade_params
    params.require(:trade).permit(:fiat_price_cents, :fiat_amount_cents, :cryptocurrency_amount, :transaction_type, :date_of_trade)
  end

  def crypto_service
    # API MEMOIZATION CODE
    @crypto_service ||= CryptoCompareService.new
  end
end
