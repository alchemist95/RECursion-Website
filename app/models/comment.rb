class Comment < ApplicationRecord
	
	belongs_to :user
	belongs_to :question
	validates_presence_of :question_id

end
