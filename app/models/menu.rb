class Menu < ApplicationRecord
	has_many :courses
	has_many :reservations
	accepts_nested_attributes_for :courses
	mount_uploader :image, ImageUploader
	
	validates :menu_title, presence: true, length: { maximum: 50 }, uniqueness: true
	validates :introduce, presence: true, length: { maximum: 200 }
	# validates :image, file_size: { less_than_or_equal_to: 1000.kilobytes }
	validate  :image_size
                     
    # アップロードされた画像のサイズをバリデーションする
    def image_size
      if image.size > 5.megabytes
        errors.add(:image, "容量は5MB以下にしてください。")
      end
    end

	
end
