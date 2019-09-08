# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Menu.create(menu_title: "Bodycare もみほぐし", introduce: "お客様のお好みの力加減を確認しながら、全身をもみほぐしていきます。")
Menu.create(menu_title: "Footcare 足つぼ", introduce: "オイルを使用し、足裏の反射区、ふくらはぎ、ひざ裏までしっかり刺激し、老廃物を流していきます。")
Menu.create(menu_title: "Gut cae 腸ケア", introduce: "『腸』こそ免疫力のすべて！腸内環境が整うと『お通じ改善』『頭痛』『肩こり』『冷え』『むくみ』等の身体の不調は『イライラ』『くよくよ』ストレス等の心の安定してきます。")
Menu.create(menu_title: "Hyper Knife ハイパーナイフ", menu_image_id: "1865782ac6293c89049c41820c56fbe46b76816866049f2a4456e9c75eb0", introduce: "ハイパーナイフは高周波を身体に流し、体内の水分を振動させることで熱を発生させて脂肪を溶解、燃焼させるマシンです。「ナイフで削ぎ落としたように脂肪が取れる！！」と、好評の施術です。")
Course.create(menu_id: 1, course_name: "クイックコース", course_time: 60, price: 5000)
Course.create(menu_id: 1, course_name: "基本コース", course_time: 90, price: 7500)
Course.create(menu_id: 1, course_name: "全身しっかりコース", course_time: 120, price: 10000)
Course.create(menu_id: 2, course_name: "足つぼクイックコース", course_time: 30, price: 3000)
Course.create(menu_id: 2, course_name: "足つぼ基本コース", course_time: 60, price: 6000)
Course.create(menu_id: 2, course_name: "足つぼしっかりコース", course_time: 90, price: 9000)
Course.create(menu_id: 3, course_name: "腸ケアコース(ヘッドマッサージ付き)", course_time: 60, price: 6000)
Course.create(menu_id: 4, course_name: "基本コース", course_time: 60, price: 16000)
Course.create(menu_id: 4, course_name: "しっかり燃焼コース", course_time: 120, price: 32000)