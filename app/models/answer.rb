class Answer < ApplicationRecord

	belongs_to :user
	belongs_to :question
	has_many :upvotes

	def upvote_count
		upvotes.count
	end

end

