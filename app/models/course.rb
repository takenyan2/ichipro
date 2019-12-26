class Course < ApplicationRecord
	belongs_to :menu
	has_many :courses, dependent: :destroy
end
