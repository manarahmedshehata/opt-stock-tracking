class AssetController < ApplicationController
  def add
  	@asset = Asset.new(asset_params)
  	if @asset.save
      render json: {status: "success",asset: @asset}
    else
      render json: {status: "error"}
    end
  end

  def update_price
    @asset=Asset.find(params[:name])
    if params[:price]
      if @asset.update(price: params[:price])
        render json: {status: "success",asset: @asset}
      else
        render json: {status: "error"}
    else
      render json: {status: "error",msg: "there is no price sent to update "}
  end

  def list
  end

  def get
  end
  private
  def asset_params
    params.require(:asset).permit(:name, :price)
  end
end
