class ReservationsController < ApplicationController
  def index
    @reservation = Reservation.new
    @reservations = Reservation.all
    @course = Course.all
    @meetings = Meeting.all
    @today = Date.today
    @reservations.each do |reservation|
      @r = reservation
    end
  end

  def new
    # @user = User.find(params[:user_id])
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
    # binding.pry
    @selected_started_at = params[:started_at]
    @week_day = params[:week_day]
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

  # def schedule
  #   @reservation = Reservation.all(params[:id])
  #   @reservations = Reservation.find(params[:id])
  #   @times24 = []
  #   i = 0
  #   minutes = ["00","30"]
  #   while(i <= 23) do
  #     minutes.each { |minute|
  #     @times24.push(i.to_s + ":" + minute)
  #     }
  #     i += 1
  #   end
  # end

  def show
    
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
  end


  def create
    reservation = Reservation.new(reservation_params)
    # 次の予約開始時間を設定。
    # add_time = reservation.start_time
    # # 予約開始時間にリクエストされたコースの分数を加算。
    # add_time =+ Rational(params[:request_course_time],24*60)
    # # さらに、インターバルの30分を加算して、restart_reservation_timeに次の予約開始可能な時刻をぶっ込みたい。
    # add_time =+ Rational(30,24*60)
    # reservation.restart_reservation_time = add_time

    @request_course_time = params[:reservation][:request_course_time].to_i
    # request_course_time =reservation.request_course_time.to_i  上記と同意
    # start_timeの値は、これで受け取れる。params[:reservation]["start_time(1i)"]

    # reservation.finish_time = reservation.start_time + @request_course_time.minutes

    # ↑これをやりたい。やりたいんだけどreservation.start_timeが時間として取得できない
    # 下記で文字列として開始年月日を取得。これを時刻に直す必要がある。
    start_time = params[:reservation]["start_time(1i)"] + params[:reservation]["start_time(2i)"] + params[:reservation]["start_time(3i)"] + params[:reservation]["start_time(4i)"] + params[:reservation]["start_time(5i)"] + "00"
    t = Time.parse(start_time)
    reservation.finish_time = t +  @request_course_time.minutes

    if reservation.save
      flash[:notice] = "保存しました"
    else
      flash[:danger] = "登録に失敗しました"
      render :index
    end

    redirect_to reservations_path
  end

  def destroy
  end

  private
  def reservation_params
    # params.require(:reservation).permit(:user_name, :user_kana_name, :gender, :user_email, :user_phone_number, :request_course, :request_course_time, :start_time,:finish_time, :demand, :sales)
  end
  def kari_params
    params.require(:reservation).permit(:user_name, :user_kana_name, :gender, :user_email, :user_phone_number, :start_time, :demand, :sales)
  end


end
