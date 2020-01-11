class Reservation < ApplicationRecord

  belongs_to :course
  belongs_to :menu
  
  require "time"
  
  # 過去の予約は無効
  validate :past_time_is_not_able_to_reservation
  validate :not_sales_time_is_not_able_to_reservation

validate :make_a_reservation_is_valid_on_reserved_time

	 def make_a_reservation_is_valid_on_reserved_time
	   #byebug
    if (start_time.present? && finish_time.present?) && Reservation.where("start_time < ? and finish_time > ?",finish_time + (30 * 60), start_time - (30 * 60)).where.not(id: self.id).present?
      errors[:base] << "入力された時間はすでに予約が入っています。"
    end
  end
  
  
  def past_time_is_not_able_to_reservation
    if start_time.present?
      errors.add(:started_at, "過去の時間は予約できません。") if start_time < Time.zone.now
    end
  end
  
  # 営業時間（10時〜21時）以外の予約は弾く
  def not_sales_time_is_not_able_to_reservation
    if start_time.present?
      date = start_time.strftime("%Y-%m-%d")
      if start_time < Time.parse("#{date} 10:00:00") || finish_time > Time.parse("#{date} 21:00:00")
        errors.add(:started_at, "営業時間外です。") 
      end
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