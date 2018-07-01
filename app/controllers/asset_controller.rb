class AssetController < ApplicationController
  #POST /asset/add
  def add
  	@asset = Asset.new(asset_params)
    # check if asset saving is done or not
  	if @asset.save
      render json: {status: "success",asset: @asset}
    else
      render json: {status: "error", msg: "Can't save this asset"}
    end
  end
   # PUT /asset/update_price
  def update_price
    @asset=Asset.find_by_name(asset_params[:name])
    #Check if price is sent in request body or not
    if asset_params[:price]
      # check if asset update is done or not 
      if @asset.update(price: asset_params[:price])
        render json: {status: "success",asset: @asset}
      else
        render json: {status: "error", msg: "Can't update this asset"}
      end
    else
      render json: {status: "error",msg: "there is no price sent to update "}
    end
  end
  #GET /asset/list
  def list
    @assets=Asset.all
    render json: @assets
  end

  def get
  end
  private
  def asset_params
    params.require(:asset).permit(:name, :price)
  end
end
