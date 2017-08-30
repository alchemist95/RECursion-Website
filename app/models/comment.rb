class Comment < ApplicationRecord
	
	belongs_to :user
	belongs_to :question
	belongs_to :answer

	validates_presence_of :question_id, allow_nil: true
	validates_presence_of :answer_id, allow_nil: true

	validate :question_or_answer

	def question_or_answer
		unless question_id.blank? ^ answer_id.blank?
			errors[:base] << 'Fill either question_id or answer_id'
		end
	end

end
