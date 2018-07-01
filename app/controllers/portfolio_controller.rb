class PortfolioController < ApplicationController
  def create
  	puts "----assets----"
  	puts portfolioassets
  	puts useridfilterchecks	
  end

  def get
  end

   private
  def portfolioassets
    params.require(:portfolio).permit(:apple)
  end
  def useridfilterchecks
		params.require(:portfolio).permit(:user)
	end
end
