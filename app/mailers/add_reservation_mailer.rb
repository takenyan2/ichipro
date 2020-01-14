class AddReservationMailer < ApplicationMailer
  default from: 'suima4743@gmail.com'

  def add_reservation_mail(course_name, reservation, course_time)
    @course_name = course_name
    @reservation = reservation
    @course_time = course_time
    mail(to: "wagamama2sre@gmail.com", subject: "ichiの予約が追加されました")
  end
  
  def to_user_mail(course_name, reservation, course_time)
    @course_name = course_name
    @reservation = reservation
    @course_time = course_time
    attachments['woman-1.jpg'] = File.read("assets/images/woman-1.jpg")
    mail(to: @reservation.user_email, subject: "ichiのご予約ありがとうございます")
  end
end
