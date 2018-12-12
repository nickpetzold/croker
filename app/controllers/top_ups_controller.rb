class TopUpsController < ApplicationController
  def new
    @top_up = TopUp.new
  end

  def create
    @top_up = TopUp.new(top_up_params)
    @top_up.user = current_user
    @top_up.save!

    redirect_to new_top_up_payment_path(@top_up)
  end

  private

  def top_up_params
    params.require(:top_up).permit(:fiat_amount, :transaction_type, :date_of_top_up, :state)
  end
end
