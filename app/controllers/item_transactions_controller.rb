class ItemTransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def index
    @item_transaction_form = ItemTransactionForm.new
  end

  def create
    @item_transaction_form = ItemTransactionForm.new(item_transaction_form_params)
    if @item_transaction_form.save
      # Payjpへの決済処理の追加
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      Payjp::Charge.create(
        amount: @item.price,
        card: params[:token],
        currency: 'jpy'
      )
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def item_transaction_form_params
    params.require(:item_transaction_form).permit(
      :postal_code, :prefecture_id, :city, :address, :building, :phone_number
    ).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
  
end
