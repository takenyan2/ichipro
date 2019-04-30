# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Menu.create(menu_title: "タイ古式マッサージ", menu_image_id: nil, introduce: "タイ王国に約2500年前から伝わると言われる、その技法は実に250以上もあります。")
Menu.create(menu_title: "もみほぐし", menu_image_id: nil, introduce: "肩こりや腰痛など、日々の疲れをオールハンドで癒します。")
Course.create(menu_id: 1, course_name: "基本コース", course_time: 60, price: 7000)
Course.create(menu_id: 1, course_name: "しっかりコース", course_time: 90, price: 10000)
Course.create(menu_id: 2, course_name: "もみほぐしコース", course_time: 60, price: 5000)
Course.create(menu_id: 2, course_name: "しっかり全身もみほぐしコース", course_time: 90, price: 7000)
Course.create(menu_id: 2, course_name: "じっくり全身もみほぐしコース", course_time: 120, price: 9000)