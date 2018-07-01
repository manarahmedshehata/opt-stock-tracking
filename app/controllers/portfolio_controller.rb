class PortfolioController < ApplicationController	
  def create
  	@portfolio_creator=User.find(portfolio_creator[:user])
  	@portfolio = Portfolio.create(user:@portfolio_creator)
  	@port_assets = params[:portfolio][:assetaa]
  	#check for portfolio saving 
  	if !@portfolio.save
  		render json: {status: "error",msg: "Can't save portfolio"}
  	#check for portfolio assets
	elsif @port_assets == nil
		@portfolio.destroy
		render json: {status: "error",msg: "You have to select asset to invest on"}

	else
		@wrong_assets=[]
		@port_assets.each{ |passet|
			@asset=Asset.find_by_name(passet["name"])
			#check for exesting asset with sent name 
			#we can remove this check if there is api interface and assets are a select menue
			if !@asset or !passet["amount"] or passet["amount"] == ""
				puts "------if------"
				@wrong_assets.push(passet["name"])
			else
				@portfolio_asset = PortfolioAsset.create(portfolio: @portfolio, asset: @asset, amount: passet["amount"])
				puts "---asset save--"
				if !@portfolio_asset.save		
					puts "---asset dest--"
  				    @portfolio.destroy
					render json: {status: "error",msg: "Can't save portfolio"}
					break
				end
			end
		}
		if @wrong_assets.length !=0
			@portfolio.destroy
			@msg=@wrong_assets.map(&:inspect).join(', ')
			render json: {status: "error",msg: "These assets are not exist "+@msg+" or the mount is not added"}
		else
			render json: {status: "success",portfolio: @portfolio,portass: @portfolio_asset}
		end		
  	end
  end
 
#GET List user portfolios
  def get
  	@portfoliosdata=[]
  	#get all related portfolios
  	@portfolios_info=Portfolio.where(user: params[:user])

  	@portfolios_info.each{|portfolio|
  		@portfolio_asset_ids=PortfolioAsset.where(portfolio: portfolio.id)
  		puts  @portfolio_asset_ids
  		@portfolio_asset_ids.each{ |port_asset|
  			@asset=Asset.find(port_asset.id)
  			@asset_amount=port_asset.amount
  			@portfoliosdata.push({"asset_name": @asset["name"],"invest ammount": port_asset.amount})
  		}

  	}

  	render json: {status: "success",portfolios: @portfoliosdata}

  end

  private
  def portfolio_creator
    params.require(:portfolio).permit(:user)

  end 
end