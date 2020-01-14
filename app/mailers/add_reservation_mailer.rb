class AddReservationMailer < ApplicationMailer
  default from: 'suima4743@gmail.com'

  def add_reservation_mail(course_name)
    @course_name = course_name
    mail(to: "wagamama2sre@gmail.com", subject: "ichiの予約が追加されました")
  end
end
