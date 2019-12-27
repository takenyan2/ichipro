class Reservation < ApplicationRecord

  belongs_to :course
  belongs_to :menu
  

validate :make_a_reservation_is_valid_on_reserved_time
	 def make_a_reservation_is_valid_on_reserved_time
    if (start_time.present? && finish_time.present?) && Reservation.where("start_time < ? and finish_time > ?",finish_time,start_time).where.not(id: self.id).present?
      errors[:base] << "入力された時間はすでに予約が入っています。"
    end
  end

end