# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  email: "text@test.com",
  password: "password",
  phone: "090",
  user_name: "aaa",
  birthday: Date.new(200, 2, 2),
  notification: true
)

Player.create(
  name: "ああ",
  team: "ii",
  position: "RSB",
  country: "JPN",
  age: 26,
  height: 170,
  weight: 70,
  sell_price: 350,
  buy_price: 400
)

Player.create(
  name: "111",
  team: "111",
  position: "MDF",
  country: "ENG",
  age: 21,
  height: 170,
  weight: 70,
  sell_price: 220,
  buy_price: 420
)

# table_names = %w(players, users)
# table_names.each do |table_name|
#     path = Rails.root.join.("db/seeds", Rails.env, table_name + ".rb")
#     if File.exist?(path)
#         puts "Creating #{table_name}..."
#         require path
#     end
# end