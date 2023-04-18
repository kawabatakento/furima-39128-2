class ItemTransactionsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @transaction = ItemTransaction.new(item: @item, user: current_user)
  end
end
