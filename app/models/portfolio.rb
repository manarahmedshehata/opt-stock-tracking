class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :portfolio_assets
  has_many :assets, through: :portfolio_assets, :dependent => :destroy
end
