class AddReservationMailer < ApplicationMailer
  default from: 'suima4743@gmail.com'

  def add_reservation_mail(course_name, reservation, course_time)
    @course_name = course_name
    @reservation = reservation
    @course_time = course_time
    mail(to: "ichi_1073@yahoo.co.jp", subject: "ichiの予約が追加されました")
  end

  def to_user_mail(course_name, reservation, course_time)
    @course_name = course_name
    @reservation = reservation
    @course_time = course_time
    attachments['駐車場のご案内.pdf'] = File.read("app/assets/images/parking.pdf")
    mail(to: @reservation.user_email, subject: "ichiのご予約ありがとうございます")
  end
end
