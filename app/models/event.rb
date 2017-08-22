class Event < ApplicationRecord
	enum type: [ :lecture, :contest, :other]
end
