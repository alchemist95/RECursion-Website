class Tag < ApplicationRecord

	has_many :taggings
	has_many :questions, through: :taggings

	scope :starts_with, -> (name) { where("name like ?", "#{name}%")}

	def question_count
		questions.count
	end
end
