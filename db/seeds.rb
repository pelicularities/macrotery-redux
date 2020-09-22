# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts "starting to seed..."

puts "removing existing records..."
User.destroy_all
Eatery.destroy_all
Cuisine.destroy_all
puts "existing records removed!"

puts "seeding users..."
users = [
  {
    email: 'grace@grace.com',
    password: 'grace123',
    first_name: 'Grace',
    last_name: 'Teng',
    phone_number: '12345678',
    protein: 150,
    carbs: 200,
    fats: 60
  },
  {
    email: 'zack@zack.com',
    password: 'zack123',
    first_name: 'Zack',
    last_name: 'Xu',
    phone_number: '23456789',
    protein: 180,
    carbs: 250,
    fats: 80
  },
  {
    email: 'allen@allen.com',
    password: 'allen123',
    first_name: 'Allen',
    last_name: 'Chung',
    phone_number: '34567890',
    protein: 180,
    carbs: 180,
    fats: 80
  },
  {
    email: 'steph@steph.com',
    password: 'steph123',
    first_name: 'Stephen',
    last_name: 'Das',
    phone_number: '45678901',
    protein: 200,
    carbs: 200,
    fats: 75
  }
]
users.each do |user|
  User.create!(user)
  puts "seeded user #{user[:email]}"
end
puts 'users seeded!'

puts 'seeding user meals...'
User.all.each do |user|
  ['Breakfast', 'Lunch', 'Dinner'].each do |meal|
    UserMeal.create!(
      user: user,
      name: meal,
      protein: Faker::Number.between(from: 40, to: 75),
      carbs: Faker::Number.between(from: 50, to: 90),
      fats: Faker::Number.between(from: 20, to: 35)
    )
    puts "seeded #{user.first_name}'s #{meal}"
  end
end
puts 'user meals seeded!'

puts 'seeding cuisines...'
# cuisines = [
#   'Singaporean',
#   'Malaysian',
#   'Indonesian',
#   'Spanish',
#   'Japanese',
#   'Italian',
#   'British',
#   'American',
#   'Mexican',
#   'French',
#   'Chinese',
#   'Korean',
#   'Thai',
#   'Middle Eastern',
#   'Indian'
# ]
# cuisines.each do |cuisine|
#   Cuisine.create!(name: cuisine)
#   puts "seeded #{cuisine}"
# end
15.times do
  cuisine = Cuisine.create!(name: Faker::Restaurant.type)
  puts "seeded #{cuisine.name}"
end
puts 'cuisines seeded!'

puts 'seeding eateries...'
addresses = [
  '360 Orchard Road, Singapore',
  '1 Raffles Place, Singapore',
  '1 Woodlands Place, Singapore',
  '10 Tampines Central 1, Singapore',
  '50 Jurong Gateway Rd, Singapore',
  '3 Yung Sheng Rd, Singapore',
  '85 Bedok North St 4, Singapore',
  '137 Tampines St 11, Singapore',
  '100 Neo Tiew Rd, Singapore',
  '30 Victoria St, Singapore',
  '12 Purvis St, Singapore',
  '262 Jurong East St 24, Singapore',
  '524A Jelapang Road, Singapore',
  '243 Jalan Kayu, Singapore',
  '27 Lichfield Road, Singapore',
  '11 New Bridge Road, Singapore',
  '435 Orchard Road, Singapore',
  '68 Orchard Road, Singapore',
  '2 Orchard Turn, Singapore',
  '350 Orchard Road, Singapore'
]

addresses.each do |address|
  eatery = Eatery.new
  eatery.name = Faker::Restaurant.unique.name
  eatery.address = address
  eatery.phone_number = "6#{Faker::Number.number(digits: 7)}"
  eatery.description = Faker::Restaurant.description
  eatery.save!
  puts "seeded #{eatery.name}"
end
puts 'eateries seeded!'

puts 'seeding eatery-cuisine relationship...'
puts 'seeded eatery cuisines!'

puts "finished seeding!"