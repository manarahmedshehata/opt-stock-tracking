class CreatePortfolioAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :portfolio_assets do |t|
      t.references :portfolio, foreign_key: true
      t.references :asset, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
