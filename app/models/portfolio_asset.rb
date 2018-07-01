class PortfolioAsset < ApplicationRecord
  belongs_to :portfolio
  belongs_to :asset
  validates :portfolio, presence: true
  validates :asset, presence: true
  validates :amount, presence: true

end
