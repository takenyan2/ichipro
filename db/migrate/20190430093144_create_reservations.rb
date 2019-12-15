class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.string :user_name
      t.string :user_kana_name
      t.string :gender
      t.string :user_email
      t.string :user_phone_number
      t.string :request_course
      t.string :request_course_time
      t.date :reservation_date
      t.datetime :start_time
      t.datetime :finish_time
      t.text :demand
      t.boolean :sales, null: false, default: false
      t.timestamps
    end
  end
end
