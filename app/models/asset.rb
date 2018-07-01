class Asset < ApplicationRecord
	has_many :portfolio_assets
	has_many :portfolios, through: :portfolio_assets, :dependent => :destroy
	validates :name, uniqueness: true
	validates :name, presence: true
end
