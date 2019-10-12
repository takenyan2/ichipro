class ReservationsController < ApplicationController
  def index
    @reservation = Reservation.new
    @reservations = Reservation.all
    @course = Course.all
    @meetings = Meeting.all
    @reservations.each do |reservation|
      @r = reservation
    end
  end

  def date
    params[:date]
    @reservation = Reservation.new
    @reservations = Reservation.where(reservation_date: params[:date])
    session[:dete] = params[:date]
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



  def show
    @reservation = Reservation.find(params[:id])
  end

  def edit
  end


  def create
    reservation = Reservation.new(reservation_params)
    # 次の予約開始時間を設定。
    add_time = reservation.start_time
    # 予約開始時間にリクエストされたコースの分数を加算。
    add_time =+ Rational(reservation.request_course_time,24*60)
    # さらに、インターバルの30分を加算して、restart_reservation_timeに次の予約開始可能な時刻をぶっ込みたい。
    add_time =+ Rational(30,24*60)
    reservation.restart_reservation_time = add_time
    if reservation.save
      flash[:notice] = "保存しました"
    else
      flash[:danger] = "登録に失敗しました"
      render :index
    end
    redirect_to reservations_done_path
  end

  def destroy
  end

  private
  def reservation_params
    params.require(:reservation).permit(:user_name, :user_kana_name, :gender, :user_email, :user_phone_number, :request_course, :request_course_time, :reservation_date, :start_time, :demand, :sales)
  end
  def kari_params
    params.require(:reservation).permit(:user_name, :user_kana_name, :gender, :user_email, :user_phone_number, :start_time, :demand, :sales)
  end


end
