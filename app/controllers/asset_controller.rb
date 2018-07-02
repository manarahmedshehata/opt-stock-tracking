class AssetController < ApplicationController
  def_param_group :asset do
  param :name, String, "asset name", :required => true
  param :price, Integer
  end
  #POST /asset/add
  api :POST, "asset/add", "Create a asset"
  param_group :asset
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
  api :PUT, "asset/update_price", "update asset price"
  param_group :asset
  returns :asset => :asset, :code => 200, :desc => "updated asset"
  def update_price
    @asset=Asset.find_by_name(asset_params[:name])
    #Check if price is sent in request body or not
    if !asset_params[:price]
      render json: {status: "error",msg: "there is no price sent to update "}
    #ccheck if there is asset with sent name
    elsif !@asset
      render json: {status: "error", msg: "There is no asset with `"+asset_params[:name]+"` name"}
    # check if asset update is done or not 
    elsif !@asset.update(price: asset_params[:price])
      render json: {status: "error", msg: "Can't update this asset"}
    else
      render json: {status: "success",asset: @asset}   
    end
    
  end

  #GET /asset/list
  api :GET, "asset/list", "Get all assets records"
  returns :array_of => :asset, :code => 200, :desc => "All assets"
  def list
    @assets=Asset.all
    render json: {status: "success",asset: @assets}
  end

  #GET /asset/get?name=<asset-Name>
  api :GET, 'asset/get', "get asset request is 'asset/get?name=<asset-Name>'"
  param :name, String,:desc => "asset name as query in request url" , :required => true
  returns :asset => :asset, :code => 200, :desc => "Detailed info about asset" 
  def get
    #check if there is no name parameter sent on request
    if !params[:name]
      render json: {status: "error",msg: "you have to send asset name in the url query [/asset/get?name=<asset-Name>]"}
    #check if there is no asset with sent name
    elsif !@asset=Asset.find_by_name(params[:name])
      render json: {status: "error",msg: "There is no asset with `"+asset_params[:name]+"` name"}
    else
      render json: {status: "success",asset: @asset}
    end


  end
  private
  def asset_params
    params.require(:asset).permit(:name, :price)
  end
end
