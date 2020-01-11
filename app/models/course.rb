class Course < ApplicationRecord
	belongs_to :menu
	
	validates :course_name, presence: true, length: { maximum: 50 }, :uniqueness => {:scope => :menu_id}
	validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
	
end
