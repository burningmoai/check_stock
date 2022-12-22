# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ユーザー
User.create!(name: 'ぎゃー', email: "aa@aa", encrypted_password: "aaaaaa")
# User.create(name: 'うぎゃー', email: "bb@bb", encrypted_password: "bbbbbb")
# User.create(name: 'おぎゃー', email: "cc@cc", encrypted_password: "cccccc")
# カテゴリ
Category.create!(name: '主食', user_id: "1")
Category.create!(name: '野菜類', user_id: "1")
Category.create!(name: '主食', user_id: "1")
Category.create!(name: '主食', user_id: "1")
# 食材
# お買いものリスト
# ストック
