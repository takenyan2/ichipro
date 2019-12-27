class Menu < ApplicationRecord
	attachment :menu_image
	has_many :courses
	has_many :reservations
	accepts_nested_attributes_for :courses
end
