class Course < ApplicationRecord
	belongs_to :menu
	
	validates :course_name, presence: true, length: { maximum: 50 }, uniqueness: true
end
