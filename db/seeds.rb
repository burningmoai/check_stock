# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ユーザー
users = [
  {name: 'ぎゃー', email: "aa@aa", password: "aaaaaa"},
  {name: 'うぎゃー', email: "bb@bb", password: "bbbbbb"},
  {name: 'おぎゃー', email: "cc@cc", password: "cccccc"},
]

users.each do |user|
  user_data = User.find_by(email: user[:email])
  if user_data.nil?
    User.create(
        name: user[:name],
        email: user[:email],
        password: user[:password]
      )
  end
end



# カテゴリ
categories = %w(主食 野菜類 肉類 海鮮類 調味料 お菓子 その他)
categories.each do |category|
  Category.create(
      name: category,
      user_id: current_user.id
    )
end
# Category.create!(name: '主食', user_id: "1")
# Category.create!(name: '野菜類', user_id: "1")
# Category.create!(name: '主食', user_id: "1")
# Category.create!(name: '主食', user_id: "1")
# 食材
foods = [
  {id:1, name: "米", category_id: 1},
  {id:2, name: "食パン", category_id: 1},
  {id:3, name: "キャベツ", category_id: 2},
  {id:4, name: "にんじん", category_id: 2},
  {id:5, name: "ささみ", category_id: 3},
  {id:6, name: "カニ", category_id: 4},
  {id:7, name: "クミン", category_id: 5},
  {id:8, name: "ターメリック", category_id: 5},
  {id:9, name: "チリペッパー", category_id: 5},
  {id:10, name: "おっとっと", category_id: 6},
  {id:11, name: "プロテイン", category_id: 7},
  ]
foods.each do |food|
  Food.find_or_create_by(food)
end

# Food.create!(name: '米')
# Food.create!(name: '食パン', user_id: current_user_id, )
# Food.create!(name: 'キャベツ', user_id: current_user_id)
# Food.create!(name: 'にんじん', user_id: current_user_id)
# Food.create!(name: '白菜', user_id: current_user_id)#5
# Food.create!(name: '豚肉', user_id: current_user_id)
# Food.create!(name: 'ささみ', user_id: current_user_id)
# Food.create!(name: 'カニ', user_id: current_user_id)
# Food.create!(name: 'ホタテ', user_id: current_user_id, category_id: 4)
# Food.create!(name: 'クミン', user_id: current_user_id)#10
# Food.create!(name: 'ターメリック', user_id: current_user_id, category_id: 5)
# Food.create!(name: 'カルダモン', user_id: current_user_id, category_id: 5)
# Food.create!(name: 'コリアンダー', user_id: current_user_id, category_id: 5)
# Food.create!(name: 'チリペッパー', user_id: current_user_id, category_id: 5)
# Food.create!(name: 'おっとっと', user_id: current_user_id)#15
# Food.create!(name: 'コアラのマーチ', user_id: current_user_id, category_id: 6)
# Food.create!(name: 'アポロ', user_id: current_user_id, category_id: 6)
# Food.create!(name: 'プロテイン', user_id: current_user_id)
# お買いものリスト
List.create!(user_id: current_user_id, food_id: 2, amount: 2)
List.create!(user_id: current_user_id, food_id: 7, amount: 1)
List.create!(user_id: current_user_id, food_id: 8, amount: 1)
# ストック
start_buy_day = Date.new(2022, 8, 15)
end_buy_day = Date.new(2022, 12, 15)
start_limit = Date.new(2022, 12, 15)
end_limit = Date.new(2023, 3, 31)
Stock.create!(user_id: 1, food_id: 1, category_id: 1, amount: 1, buy_day: Random.rand(start_buy_day..end_buy_day) , limit: Random.rand(start_limit..end_limit))
Stock.create!(user_id: 1, food_id: 2, category_id: 1, amount: 2)
Stock.create!(user_id: 1, food_id: 3, category_id: 2, amount: 1)
Stock.create!(user_id: 1, food_id: 4, category_id: 2, amount: 3)
Stock.create!(user_id: 1, food_id: 6, category_id: 3, amount: 1)
Stock.create!(user_id: current_user_id, food_id: 10, category_id: 5, amount: 1)
Stock.create!(user_id: current_user_id, food_id: 11, category_id: 5, amount: 1)
Stock.create!(user_id: current_user_id, food_id: 13, category_id: 5, amount: 1)
Stock.create!(user_id: current_user_id, food_id: 14, category_id: 5, amount: 1)
Stock.create!(user_id: current_user_id, food_id: 16, category_id: 6, amount: 2)
Stock.create!(user_id: current_user_id, food_id: 18, category_id: 7, amount: 2)

# ----- Guest Userデータ取得 -----
guest = User.find_by(email: 'guest@example.com')

if guest.nil?
  guest = User.create(
      name: 'guestuser',
      email: 'guest@example.com',
      password: SecureRandom.urlsafe_base64
    )
end

# ----- ゲストユーザーのカテゴリーデータ登録 -----
categories = %w(主食 野菜類 肉類 海鮮類 調味料 お菓子 その他)
categories.each do |category|
  Category.create(
      name: category,
      user_id: guest.id
    )
end