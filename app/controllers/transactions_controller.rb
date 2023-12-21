class TransactionsController < ApplicationController
  def index
    @transaction = Transaction.new
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    @transaction = Transaction.new(transaction_params)
    if @transaction.valid?
      api_pay
      @transaction.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
  def transaction_params
    params.require(:transaction).permit(:price, :text).merge(user_id: params[:user_id], token: params[:token])
  end
  

  def api_pay
    Payjp.api_key = "sk_test_35285d916314b9eb100df281"
      Payjp::Charge.create(
        amount: transaction_params[:price], #送金の値段
        card: transaction_params[:token], #カードトークン
        currency: "jpy" #通貨の種類
      )
  end
end
