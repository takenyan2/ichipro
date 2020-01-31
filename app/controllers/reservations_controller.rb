class ReservationsController < ApplicationController
  def index
    @first_day = Date.current
    set_reservation_schedule
    # @reservations = Reservation.where(start_time: Time.zone.now..Float::INFINITY).order(start_time: :asc)
    @reservations = Reservation.all.order(start_time: :asc)
    @reservations_today = Reservation.where(start_time: Time.zone.now.all_day).order(start_time: :asc)
  end

  def new
    @reservation = Reservation.new
    gon.course_array = Course.all.order(:menu_id).pluck(:menu_id, :course_name)
    gon.course_time_array = Course.all.order(:menu_id).pluck(:menu_id, :course_name, :course_time)
    @today = Date.today
    @times24 = []
    minutes = ["00","30"]
    i = 0
    while(i <= 23) do
      minutes.each { |minute|
      @times24.push(i.to_s + ":" + minute)
      }
      i += 1
    end
    @selected_start_time = params[:start_time]
    @week_day = params[:week_day]
    
  end
  
  def destroy
    @reservation = Reservation.find(params[:id])
    Reservation.find(params[:id]).destroy
    flash[:success] = "削除しました。"
    redirect_to action: 'index'
  end


  def change_schedule
    if params[:prev]
      day = params[:prev]
    elsif params[:next]
      day = params[:next]
    end  
    if day
      @first_day = day.to_date
      set_reservation_schedule
    end
  end

  def show
    @reservation = Reservation.all
    #既に予約されている日時を取得する
    @reservation.each do |res|
    day = res.start_time.year.to_s + "-" + res.start_time.month.to_s+ "-" + res.start_time.day.to_s
    puts day
    @reservation_time = []
    if res.start_time.min == 0
      start_min = res.start_time.min.to_s + "0"
      @reservation_time.push(res.start_time.hour.to_s + ":" + start_min)
    end
    @reservation_time.push(res.start_time.hour.to_s + ":" + res.start_time.min.to_s)
    puts @reservation_time
  end

    @times24 = []
    i = 0
    minutes = ["00","30"]
    while(i <= 23) do
      minutes.each { |minute|
      @times24.push(i.to_s + ":" + minute)
      }
      i += 1
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
    gon.course_name = Course.find(@reservation.course_id).course_name
    gon.course_array = Course.all.order(:menu_id).pluck(:menu_id, :course_name)
    gon.course_time_array = Course.all.order(:menu_id).pluck(:menu_id, :course_name, :course_time)
  end


  def create
    @reservation = Reservation.new(reservation_params)
    course = Course.where(menu_id: params[:reservation][:menu_id]).find_by(course_name: params[:reservation][:course_name])
    if params[:is_holiday].present?
      @course_time = 630
      temp_start_time = @reservation.start_time.strftime("%Y-%m-%d")
      @reservation.start_time = Time.parse(temp_start_time + '-01:00')
    else
      @course_time = course.course_time.to_i
    end  
    @reservation.finish_time = @reservation.start_time + @course_time.minutes
    @reservation.course_id = course.id
    if @reservation.save
      AddReservationMailer.add_reservation_mail(params[:reservation][:course_name], @reservation, @course_time).deliver_later
      AddReservationMailer.to_user_mail(params[:reservation][:course_name], @reservation, @course_time).deliver_later
      flash[:success] = "予約が完了しました。"
    else
      flash[:danger] = "予約日時を見直して再度ご予約ください。"
    end
    redirect_to action: 'index'
    logger.debug @reservation.errors.inspect
  end
  
  def update
    @reservation = Reservation.find(params[:id])
    course = Course.where(menu_id: params[:reservation][:menu_id]).find_by(course_name: params[:reservation][:course_name])
    @course_time = course.course_time.to_i
    @update_reservation = Reservation.new(reservation_params)
    @reservation.finish_time = @update_reservation.start_time + @course_time.minutes
    if @reservation.update_attributes(reservation_params)
      flash[:success] = "#{@reservation.user_name}様の基本情報を更新しました。"
    else
      flash[:danger] = "予約の更新は失敗しました。" + @reservation.errors.full_messages.join("/")
    end
    redirect_to action: 'index'
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    Reservation.find(params[:id]).destroy
    flash[:success] = "削除しました。"
    redirect_to action: 'index'
  end
  
  def all_index
    @reservations = Reservation.paginate(page: params[:page], per_page: 20).search(params[:search], params[:search_date], params[:search_history]).order(start_time: :asc)
  end
  
  def all_show
    @reservation = Reservation.find(params[:id])
  end
  

  private
  
  # def kari_params
  #   params.require(:reservation).permit(:user_name, :user_kana_name, :gender, :user_email, :user_phone_number, :start_time, :demand, :sales, :course_name, :request_course)
  # end


  private
  
  def set_reservation_schedule
      @week_day = (@first_day..@first_day.since(7.days))
      # @reservations = Reservation.where("finish_time > ?",Time.zone.now)
      @reservations = Reservation.all
      @times = 22.times.map.each_with_index {|i| Time.parse("10:00")+30.minutes*i}
      @time_number = 10.times.map.each_with_index {|i| l(Time.parse("11:00")+1.hours*i,format: :shorttime)}
  end
    
  def reservation_params
      params.require(:reservation).permit(:user_name, :user_kana_name, :user_email, :user_phone_number, :start_time, :demand, :menu_id, :birthday, :request_course_time)
    end

end