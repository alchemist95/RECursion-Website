class Question < ApplicationRecord
	
	has_many :answers
	has_many :upvotes
	belongs_to :user
	has_many :comments
	has_many :follows


end
