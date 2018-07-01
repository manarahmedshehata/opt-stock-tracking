class Asset < ApplicationRecord
	has_and_belongs_to_many :portfolios
	validates :name, uniqueness: true

end
