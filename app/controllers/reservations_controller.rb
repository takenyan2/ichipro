class ReservationsController < ApplicationController
  def index
    # byebug
    @first_day = Date.current
    set_reservation_schedule
    @reservations = Reservation.where(start_time: Time.zone.now..Float::INFINITY).order(start_time: :asc)
  end

  def new
    @reservation = Reservation.new
    @course = Course.all
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

  def date
    params[:date]
    @reservation = Reservation.new
    @reservations = Reservation.where(reservation_date: params[:date])
    @reservation.request_course = session[:request_course]
    @reservation.request_course_time = session[:request_course_time]
  end

  def time
    @reservations = Reservation.where(reservation_date: params[:date])
    @reservation = Reservation.new
    session[:request_course] = @reservation.request_course
    # session[:request_course_time] = @reservation.request_course_time
  end

  def confirme
    @reservations = Reservation.where(reservation_date: params[:date])
    @reservation = Reservation.new(kari_params)
    @reservation.date = session[:dete]
    @reservation.request_course = session[:request_course]
    @reservation.request_course_time = session[:request_course_time]
  end

  def done
    @reservation = Reservation.new(reservation_params)
    # 予約済みの時間を潰すメソッド
    # 予約可能だったらsaveしてセッション破棄
    # セッションを保持している間に他のユーザーが予約していないかチェック(予約可能かどうか判断するメソッド)
    @reservation.save
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
    # byebug
    # @reservations = Reservation.find(params[:id])
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
    # この書き方だと、00の時間のstart_timeが重複してしまう。
    # 0の時間のものを配列から外す処理が必要。
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
  end


  def create
    # byebug
    @reservation = Reservation.new(reservation_params)
    # @reservation.course_id = Course.find_by(course_name: params[:reservation][:course_name]).id
    @course_time = Course.find_by(id: params[:reservation][:course_id]).course_time.to_i
    # @course_time = params[:course_time].to_i
    @reservation.finish_time = @reservation.start_time + @course_time.minutes
    if @reservation.save
      flash[:success] = "予約が完了しました。"
    else
      flash[:danger] = "予約ができませんでした。"
    end
    redirect_to action: 'index'
    logger.debug @reservation.errors.inspect 
  end
  
  def update
    @reservation = Reservation.find(params[:id])
    @course_time = Course.find_by(id: params[:reservation][:course_id]).course_time.to_i
    @reservation.finish_time = @reservation.start_time + @course_time.minutes
    if @reservation.update_attributes(reservation_params)
      flash[:success] = "#{@reservation.user_name}様の基本情報を更新しました。"
    else
      flash[:danger] = "予約の更新は失敗しました。<br>" + @reservation.errors.full_messages.join("<br>")
    end
    redirect_to action: 'index'
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    Reservation.find(params[:id]).destroy
    flash[:success] = "削除しました。"
    redirect_to action: 'index'
  end

  private
  
  def kari_params
    params.require(:reservation).permit(:user_name, :user_kana_name, :gender, :user_email, :user_phone_number, :start_time, :demand, :sales, :course_name, :request_course)
  end


  private
  
  def set_reservation_schedule
      @week_day = (@first_day..@first_day.since(7.days))
      @reservations = Reservation.where("finish_time > ?",Time.zone.now)
      @times = 48.times.map.each_with_index {|i| Time.parse("0:00")+30.minutes*i}
      @time_number = 23.times.map.each_with_index {|i| l(Time.parse("1:00")+1.hours*i,format: :shorttime)}
  end
    
  def reservation_params
      params.require(:reservation).permit(:user_name, :user_kana_name, :user_email, :user_phone_number, :start_time, :demand, :course_id, :menu_id)
    end

end