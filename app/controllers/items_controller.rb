class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :move_to_root, only: [:edit, :update]

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
    @is_item_owner = @item.user == current_user
    @item_sold = ItemTransaction.exists?(item_id: @item.id)
  end

  def edit
    @item_sold = ItemTransaction.exists?(item_id: @item.id)
  end

  def update
    @item_sold = ItemTransaction.exists?(item_id: @item.id)
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    if @item.user_id == current_user.id 
      @item.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id,
                                 :shipping_time_id, :price, :image).merge(user_id: current_user.id)
  end

  def move_to_root
    return unless current_user.id != @item.user_id

    redirect_to root_path
  end

  def set_item
    @item = Item.find(params[:id])
    @item_sold = ItemTransaction.exists?(item_id: @item.id)
  end
end
