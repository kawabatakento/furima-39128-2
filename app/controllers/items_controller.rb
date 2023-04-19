class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      flash.now[:alert] = @item.errors.full_messages.join(', ')
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @is_item_owner = @item.user == current_user
    @item_sold = ItemTransaction.exists?(item_id: @item.id)
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_time_id, :price, :image).merge(user_id: current_user.id)
  end
end
