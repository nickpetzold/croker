
class PaymentsController < ApplicationController
  before_action :set_top_up

  def new
  end

  def create
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
    redirect_to new_top_up_payment(@top_up)
  end

  private

  def set_top_up
    @top_up = current_user.top_ups.where(state: 'pending').find(params[:top_up_id])
  end
end
