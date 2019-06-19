class Menu < ApplicationRecord
	attachment :menu_image
	has_many :courses
	accepts_nested_attributes_for :courses
end
