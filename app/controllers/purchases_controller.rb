class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :purchase_item, only: [:index, :create]
  before_action :redirect_user, only: [:index, :create]

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(shipping_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def shipping_params
    params.require(:purchase_address).permit(:postal_code, :municipality, :house_number, :building_name, :phone_number, :prefecture_id, :number, :exp_month, :exp_year, :cvc).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def purchase_item
    @item = Item.find(params[:item_id])
  end

  def redirect_user
    redirect_to root_path if current_user == @item.user || @item.purchase.present?
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: shipping_params[:token],
      currency: 'jpy'
    )
  end
end
