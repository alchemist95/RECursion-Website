class User < ApplicationRecord

	has_many :identities
	has_many :questions
	has_many :answers
	has_many :upvotes
	has_many :comments
	has_many :follows

	enum role: [ :normal, :admin ]

	scope :starts_with, -> (nickname) { where("nickname like ? OR nickname like ? OR name like ? OR name like ?",
		"#{nickname}%", "#{nickname.upcase}%", "#{nickname}%", "#{nickname.upcase}%" )}

	def self.sign_in_from_omniauth(auth)
		
		identity = Identity.find_or_create_by(uid: auth.uid, provider: auth.provider)
		user = identity.user
		newuser = false
		if user.nil?
			email = auth.info.email
			puts 'Email'
			puts email
			present_user = User.where(email: email).first
			if present_user.nil?
				newuser = true
				user = create_user_from_omniauth(auth)
			else
				user = present_user
			end
		end
		if identity.user != user
			identity.user = user
			identity.save!
		end
	    
		user
	end

	def self.create_user_from_omniauth(auth)
		
		info = auth.info.symbolize_keys!
		user = User.new
		user.name = info.name
		user.email = info.email
		user.image_url = info.image
		user.role = 0
		user.save!
		user

	end

	def already_liked(post)
		post.likes.where(user_id: id).any?
	end

	def already_upvoted(answer)
		answer.upvotes.where(user_id: id).any?
	end

	def already_followed(question)
		question.follows.where(user_id: id).any?
	end

end
