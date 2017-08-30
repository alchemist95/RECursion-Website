class Post < ApplicationRecord
	belongs_to :user
	has_many :likes

	enum status: [:pending, :verified]
end
