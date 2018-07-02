class AddStocksToPortfolioAssets < ActiveRecord::Migration[5.0]
  def change
    add_column :portfolio_assets, :stocks, :float, :default => 0
  end
end
