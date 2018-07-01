class PortfolioController < ApplicationController
  def create
  	@portfolio_creator=User.find(portfolio_creator[:user])
  	@portfolio = Portfolio.create(user:@portfolio_creator)
  	@port_assets = params[:portfolio][:assetaa]
  	if @portfolio.save
  		if @port_assets != nil
  			@port_assets.each{ |passet|
  				@asset=Asset.find_by_name(passet["name"])
  				
  				@portfolio_asset = PortfolioAsset.create(portfolio: @portfolio, asset: @asset, amount: passet["amount"])
  				@portfolio_asset.save
  			}
  		else
  			render json: {status: "error",msg: "You have to select asset to invest on"}
  		end
  		render json: {status: "success",portfolio: @portfolio,portass: @portfolio_asset}
  	else
  		render json: {status: "error",msg: "Can't save portfolio"}
  	end
  	
  end

  def get
  end

   private
  def portfolio_creator
    params.require(:portfolio).permit(:user)
  end 
  def useridfilterchecks
		params.require(:portfolio).permit(:user)
	end
end
