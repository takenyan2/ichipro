# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Started Seed...'

2.times do |n|
  Admin.create(
    admin_name: "test_admin#{n}",
    email: "test_admin#{n}@example.com",
    password: 'password',
    password_confirmation: 'password',
  )
end
puts 'Created Admin!'

Menu.create(menu_title: "改善基本コース", menu_image_id: "", 
introduce: "身体の土台である軸と重心バランスを整えて体の歪みをリセット。じっくり全身をもみほぐして筋肉バランスを整える疲労回復改善コース。
				慢性的な首、肩、背中、腰の辛さがある方、冷え、頭痛持ちがある方にオススメのコースとなっております。")
Menu.create(menu_title: "極上リラクゼーションコース", menu_image_id: "", 
introduce: "身体の土台である軸と重心バランスを整えて体の歪みをリセットした後、
				全身を優しくゆったりとアロマトリートメント。
				心身の緊張をほぐす癒しメニューが組み合わせになった改善コース。
				慢性的な首、肩、背中、腰の辛さがある方、冷え、頭痛持ちがある方に
				オススメのコースとなっております。")
Menu.create(menu_title: "Bodycare もみほぐし", menu_image_id: "", introduce: "お客様のお好みの力加減を確認しながら、全身をもみほぐしていきます。")
Menu.create(menu_title: "Footcare 足つぼ", menu_image_id: "", introduce: "オイルを使用し、足裏の反射区、ふくらはぎ、ひざ裏までしっかり刺激し、老廃物を流していきます。")
Menu.create(menu_title: "Gut cae 腸ケア", menu_image_id: "", introduce: "『腸』こそ免疫力のすべて！腸内環境が整うと『お通じ改善』『頭痛』『肩こり』『冷え』『むくみ』等の身体の不調は『イライラ』『くよくよ』ストレス等の心の安定してきます。")
Menu.create(menu_title: "Hyper Knife ハイパーナイフ", menu_image_id: "", introduce: "ハイパーナイフは高周波を身体に流し、体内の水分を振動させることで熱を発生させて脂肪を溶解、燃焼させるマシンです。「ナイフで削ぎ落としたように脂肪が取れる！！」と、好評の施術です。")
puts 'Created Menu!'

Course.create(menu_id: 1, course_name: "全身整体ベーシック", course_time:60 , price:5000 )
Course.create(menu_id: 1, course_name: "全身整体ベーシック（じっくり）", course_time:120 , price:12000 )
Course.create(menu_id: 2, course_name: "極上整体プレミアム", course_time:90 , price:13000 )
Course.create(menu_id: 2, course_name: "極上整体プレミアム（じっくり）", course_time:120 , price:15000 )
Course.create(menu_id: 3, course_name: "クイックコース", course_time: 60, price: 5000)
Course.create(menu_id: 3, course_name: "基本コース", course_time: 90, price: 7500)
Course.create(menu_id: 3, course_name: "全身しっかりコース", course_time: 120, price: 10000)
Course.create(menu_id: 4, course_name: "足つぼクイックコース", course_time: 30, price: 3000)
Course.create(menu_id: 4, course_name: "足つぼ基本コース", course_time: 60, price: 6000)
Course.create(menu_id: 4, course_name: "足つぼしっかりコース", course_time: 90, price: 9000)
Course.create(menu_id: 5, course_name: "腸ケアコース(ヘッドマッサージ付き)", course_time: 60, price: 6000)
Course.create(menu_id: 6, course_name: "基本コース", course_time: 60, price: 16000)
Course.create(menu_id: 6, course_name: "しっかり燃焼コース", course_time: 120, price: 32000)
puts 'Created Course!'

Question.create(
  user_question: '当日予約はできますか？',
  answer: 'できます。完全予約制のため、当日のご予約につきましては、お電話にてご予約を承っております。出来るだけ余裕をもってのご予約をお勧めしております。'
)

Question.create(
  user_question: '予約内容は変更できますか？',
  answer: 'はい。当日ご来店されてからの変更は、ご希望に添えない場合もございますので、できるだけ前日までにご連絡をお願いいたします。'
)

Question.create(
  user_question: '生理中や妊娠中でも大丈夫ですか？',
  answer: '生理中でもお受けいただけます。体内循環が活性されるので、一時的に経血が多くなる場合もありますが、「出るべきものが早く出る」ということで、体への影響は心配ありません。妊娠中の方、妊娠している可能性のある方については、安全面を考慮しご遠慮いただいております。'
)

Question.create(
  user_question: 'オイルによって肌荒れ等が起きる場合がありますか？',
  answer: '当店はお肌に優しいオイルを使用しておりますが、お客様の体質・体調によってオイルとの相性がございます。皮膚に合わない場合は、肌荒れやただれの原因になりますので、不安なお客様はお控えくださいませ。'
)

puts 'Created Question!'

puts 'Finished Seed...'