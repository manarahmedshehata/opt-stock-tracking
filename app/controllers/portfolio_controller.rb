class PortfolioController < ApplicationController	

  #POST /portfolio/create
#   =begin
#   Resuest body must be {
# 	"portfolio":{
# 		"asset":[{"name": <asset_name>,"amount":<invest_amount>},{"name": <asset_name>,"amount":<invest_amount>},...],
# 		"user": <creator_id>
# 	}
# }
#   =end
  def_param_group :asset do
  param :name, String, "asset name"
  param :price, Integer
  end
  def_param_group :user do
  param :name, String, "user name"
  end
  api :POST, 'potfolio/create' , "Create the portfolio"
   param :asset, Array[:asset],:desc => "array of submitted assets with asset Name and invested amount in this asset", :required => true
   param :user, Integer,:desc => "creator refrence to user", :required => true
  def create
  	@portfolio_creator=User.find(portfolio_creator[:user])
  	@portfolio = Portfolio.create(user:@portfolio_creator)
  	@port_assets = params[:portfolio][:asset]
  	#check for portfolio saving 
  	if !@portfolio.save
  		render json: {status: "error",msg: "Can't save portfolio"}
  	#check for portfolio assets
	elsif @port_assets == nil
		@portfolio.destroy
		render json: {status: "error",msg: "You have to select asset to invest on"}

	else
		@wrong_assets=[]
		@portfolio_assets=[]
		@port_assets.each{ |passet|
			@asset=Asset.find_by_name(passet["name"])
			#check for exesting asset with sent name 
			#we can remove this check if there is api interface and assets are a select menue
			if !@asset or !passet["amount"] or passet["amount"] == ""
				puts "------if------"
				@wrong_assets.push(passet["name"])
			else
				#calculate invested stocks number

				@stocks_no = passet["amount"].to_f / @asset.price 
				#/
				puts @stocks_no
				@portfolio_asset = PortfolioAsset.create(portfolio: @portfolio, asset: @asset, amount: passet["amount"],stocks: @stocks_no)
				puts "---asset save--"
				if !@portfolio_asset.save		
					puts "---asset dest--"
  				    @portfolio.destroy
					render json: {status: "error",msg: "Can't save portfolio"}
					break
				else
					@portfolio_assets.push(@portfolio_asset)
				end
			end
		}
		if @wrong_assets.length !=0
			@portfolio.destroy
			@msg=@wrong_assets.map(&:inspect).join(', ')
			render json: {status: "error",msg: "These assets are not exist "+@msg+" or the mount is not added"}
		else
			render json: {status: "success",portfolio: @portfolio,portass: @portfolio_assets}
		end		
  	end
  end
 
#GET List user portfolios
#GET /portfolio/get?user=<User_id>
  api :GET, 'potfolio/get', "get user portfolios request is 'potfolio/get?user=<User_id>'"
  param :user, Integer,:desc => "creator id" , :required => true
  returns :code => 200, :desc => "Detailed info about all the portifolios related to this user" do
	  param :portfolios,Array[:portfolio], :desc => "Detailed info about all the portifolios related to this user"
  end
  def get
  	@portfoliosdata=[]
  	#get all related portfolios
  	@portfolios_info=Portfolio.where(user: params[:user])
  	@portfolio_count=0
  	@portfolios_info.each{|portfolio|
  		@portfolio_asset_ids=PortfolioAsset.where(portfolio: portfolio.id)
  		puts  @portfolio_asset_ids
  		@portfolio_data=[]
  		@portfolio_asset_ids.each{ |port_asset|
  			puts port_asset.id
  			@asset=Asset.find(port_asset.asset_id)
  			@invest_amount=port_asset["stocks"].to_f * @asset.price.to_f
  			@portfolio_data.push({"asset_name": @asset["name"],"invest amount": @invest_amount})
  			#@portfoliosdata.push({"asset_name": @asset["name"],"invest amount": @invest_amount})
  		}

  		@portfoliosdata.push({'portfolio': @portfolio_data})
  		@portfolio_count=@portfolio_count+1
  	}

  	render json: {status: "success",portfolios: @portfoliosdata}

  end

  private
  def portfolio_creator
    params.require(:portfolio).permit(:user)

  end 
end