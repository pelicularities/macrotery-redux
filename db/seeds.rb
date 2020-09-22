# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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

puts "finished seeding!"