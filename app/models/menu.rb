class Menu < ApplicationRecord
	attachment :menu_image
	has_many :courses
end
