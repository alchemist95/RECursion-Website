class Tag < ApplicationRecord
	has_many :taggings
	has_many :questions, through: :taggings

	scope :starts_with, -> (name) { where("name like ?", "#{name}%")}
end
