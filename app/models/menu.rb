class Menu < ApplicationRecord
	attachment :menu_image, type: :image
	has_many :courses
	has_many :reservations
	accepts_nested_attributes_for :courses
	
	validates :menu_title, presence: true, length: { maximum: 50 }, uniqueness: true
	validates :introduce, presence: true, length: { maximum: 200 }
	validates :menu_image, file_size: { less_than_or_equal_to: 1000.kilobytes }
                     


	
end
