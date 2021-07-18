class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show]#:destroy

  def index
    @items = Item.includes(:user).order("created_at ASC")
  end
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  # def destroy
    # if @item.destroy
    #   redirect_to root_path
    # else
    #   redirect_to root_path
    # end
  # end

  def set_item
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:items_name, :price, :description, :category_id, :status_id, :delivery_charge_id, :prefecture_id, :days_id, :image).merge(user_id: current_user.id)
  end
end
