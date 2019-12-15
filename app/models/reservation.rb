class Reservation < ApplicationRecord

validate :make_a_reservation_is_valid_on_reserved_time
	def make_a_reservation_is_valid_on_reserved_time
	    if (start_time.present? && finish_time.present?) && Reservation.where("start_time < ? and finish_time > ?",finish_time,start_time)
	      errors[:base] << "入力された時間はすでに予約が入っています。"
	    end
	end

end
