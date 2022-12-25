# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


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
categories = %w(野菜類 肉類 その他)
categories.each do |category|
  Category.find_or_create_by(
      name: category,
      user_id: guest.id
    )
end
# ----- ゲストユーザーの食材データ登録 -----
foods = %w(キャベツ にんじん)
foods.each do |food|
  Food.find_or_create_by(
      name: food,
      category_id: 1,
      user_id: guest.id
    )
end
# ----- ゲストユーザーのお買いものリストデータ登録 -----
List.find_or_create_by(
    user_id: guest.id,
    food_id: 1,
    amount: 1,
  )