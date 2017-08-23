class Post < ApplicationRecord
	belongs_to :user

	enum status: [:pending, :verified]
end
