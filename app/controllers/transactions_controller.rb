class TransactionsController < ApplicationController
  def index
    @transaction = Transaction.new
  end

  def create
    binding.pry
    @transaction = Transaction.new(transaction_params)
    if @transaction.vaid?
      @transaction.save
      redirect_to user_path(@transaction.user)
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
  def transaction_params
    params.require(:transaction).permit(:price, :text).merge(token: params[:token])
  end
end
