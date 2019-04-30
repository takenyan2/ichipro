class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.integer :menu_id
      t.string :course_name
      t.integer :course_time
      t.integer :price

      t.timestamps
    end
  end
end
