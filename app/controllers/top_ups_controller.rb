class TopUpsController < ApplicationController
  def new
    @top_up = TopUp.new
  end

  def create
    @top_up = TopUp.new(top_up_params)
    @top_up.user = current_user
    @top_up.save!

   customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
      )

    charge = Stripe::Charge.create(
    customer:     customer.id,   # You should store this customer id and re-use it.
    amount:       @top_up.fiat_amount_cents,
    description:  "Top up of #{@top_up.fiat_amount}",
    currency:     @top_up.fiat_amount.currency
    )

    @top_up.update(payment: charge.to_json, state: 'paid')
    current_user.fiat_balance += @top_up.fiat_amount
    current_user.save
    redirect_to dashboard_path

  rescue Stripe::CardError => e
    flash[:alert] = e.message
  end

  private

  def set_top_up
    @top_up = current_user.top_ups.where(state: 'pending').find(params[:top_up_id])
  end

  def top_up_params
    params.require(:top_up).permit(:fiat_amount, :transaction_type, :date_of_top_up, :state)
  end
end
