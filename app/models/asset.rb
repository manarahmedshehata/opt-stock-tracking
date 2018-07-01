class Asset < ApplicationRecord
	has_many :portfolio_assets
	has_many :portfolios, through: :portfolio_assets
	validates :name, uniqueness: true

end
