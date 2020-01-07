class Reservation < ApplicationRecord

  belongs_to :course
  belongs_to :menu
  
  require "time"
  

validate :make_a_reservation_is_valid_on_reserved_time
	 def make_a_reservation_is_valid_on_reserved_time
    if (start_time.present? && finish_time.present?) && Reservation.where("start_time < ? and finish_time > ?",finish_time,start_time).where.not(id: self.id).present?
      errors[:base] << "入力された時間はすでに予約が入っています。"
    end
  end
  
  # 予約を絞り込み検索します。
  def self.search(search, search_date, search_history)
    
    
    if search.present? && search_date.present?
      where(['user_name LIKE ? OR user_phone_number LIKE ? OR user_kana_name LIKE ? OR demand LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
      .where(start_time: Time.parse("#{search_date}").all_day)
    elsif search_date.present?
      where(start_time: Time.parse("#{search_date}").all_day)
    elsif search.present?
      if search_history.present?
      where(['user_name LIKE ? OR user_phone_number LIKE ? OR user_kana_name LIKE ? OR demand LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
      .where('start_time <= ?', Time.current)
      else
        where(['user_name LIKE ? OR user_phone_number LIKE ? OR user_kana_name LIKE ? OR demand LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
        .where('start_time > ?', Time.current)
      end
    else
      if search_history.present?
        where('start_time <= ?', Time.current)
      else
        where('start_time > ?', Time.current)
      end
    end
  end

end