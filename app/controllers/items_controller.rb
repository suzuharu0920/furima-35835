class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :redirect_to_index, only: [:edit, :update, :destroy]
  def index
    @items = Item.includes(:user).order('created_at ASC')
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

  def edit
    redirect_to root_path if current_user == @item.user || @item.purchase.present?
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
    end
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:items_name, :price, :description, :category_id, :status_id, :delivery_charge_id,
                                 :prefecture_id, :days_id, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def redirect_to_index
    redirect_to root_path unless current_user.id == @item.user_id
  end
end
