# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'open-uri'

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
    Macro.create!(
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
  cuisine = Cuisine.create!(name: Faker::Restaurant.unique.type)
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

logos = [
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/attachment_103367090-e1571110045215.jpg',
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/attachment_97787761-e1571109999721.jpg',
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/attachment_59509361-e1571108905481.png',
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/attachment_99478007-e1571112167353.png',
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/attachment_40533723-e1571112100668.png',
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/attachment_90692173-e1571110647786.png',
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/attachment_93150414-e1571110566194.png',
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/attachment_66602497-e1571115384951.jpg',
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/attachment_92127945-e1571116006606.jpg',
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/f87d59b6-c3df-4ce0-a9a2-073c8b98d2a8.jpg',
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/attachment_89345375.jpg',
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/attachment_77512603-e1571186033116.png',
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/mugaritz-restaurant.jpg',
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/attachment_57615794-e1571114994767.png',
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/attachment_94283857-e1571185890515.jpg',
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/attachment_102682959-e1571116039684.png',
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/attachment_72730158-e1571110735270.png',
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/attachment_89348086-e1571112998256.png',
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/attachment_45092251.png',
  'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/1d712e10-525a-4cc2-84f2-36e66336c0d0-e1571115090968.png'
]

addresses.each_with_index do |address, index|
  eatery = Eatery.new
  eatery.name = Faker::Restaurant.unique.name
  eatery.address = address
  eatery.phone_number = "6#{Faker::Number.number(digits: 7)}"
  eatery.description = Faker::Restaurant.description
  eatery.save!

  file = URI.open(logos[index])
  content_type = "image/#{logos[index][-3, 3]}"
  eatery.photo.attach(io: file, filename: "logo#{index}.png", content_type: content_type)

  puts "seeded #{eatery.name}"
end
puts 'eateries seeded!'

puts 'seeding eatery-cuisine relationship...'
Eatery.all.each do |eatery|
  2.times do
    eatery_cuisine = EateryCuisine.create!(eatery: eatery, cuisine: Cuisine.all.sample)
    puts "#{eatery.name} is a #{eatery_cuisine.cuisine.name} restaurant!"
  end
end
puts 'seeded eatery cuisines!'

puts 'seeding dishes...'

dish_images = [
  'CA2NgpLIqa0',
  'zcUgjyqEwe8',
  'ZuIDLSz3XLg',
  'MNtag_eXMKw',
  'IGfIGP5ONV0',
  '8Nc_oQsc2qQ',
  'w6ftFbPCs9I',
  'EvoIiaIVRzU',
  'jpkfc5_d-DI',
  'OFismyezPnY',
  'vzX2rgUbQXM',
  'jUPOXXRNdcA',
  'XoByiBymX20',
  'oaz0raysASk',
  'ennARkXrF74',
  'oT7_v-I0hHg',
  'CvLZ6hbIemI',
  's7FuT9HYoxM',
  'LCaBh7QSGr8',
  'O4CVzHODjjM'
]
dish_images.map! { |id| "https://source.unsplash.com/#{id}" }

Eatery.all.each do |eatery|
  10.times do
    dish = Dish.new
    dish.eatery = eatery
    dish.name = Faker::Food.unique.dish
    dish.price = (Faker::Number.between(from: 1, to: 400) * 5.0)/100
    dish.protein = Faker::Number.between(from: 10, to: 60)
    dish.carbs = Faker::Number.between(from: 40, to: 120)
    dish.fats = Faker::Number.between(from: 15, to: 50)
    dish.description = Faker::Food.description
    dish.save!

    dish_image = dish_images.sample
    file = URI.open(dish_image)
    dish.photo.attach(io: file, filename: "dish#{dish.id}.png", content_type: 'image/jpg')

    puts "seeded dish #{dish.name}"
  end
  puts "seeded dishes for #{eatery.name}!"
  Faker::Food.unique.clear
end
puts 'seeded all dishes!'

puts 'seeding orders...'
User.all.each do |user|
  3.times do
    order = Order.new
    order.user = user
    order.dine_in = [true, false].sample
    order.save!
    puts "created an order for #{user.first_name}"
    eatery = Eatery.all.sample
    (0..2).to_a.each do |index|
      order_dish = OrderDish.create!(
        order: order,
        dish: eatery.dishes[index],
        quantity: [1, 2, 3].sample
      )
      puts "added #{order_dish.dish.name} to order #{order.id}"
    end
    order.save!
    puts "ordered from #{eatery.name} for #{user.first_name}"
  end
  puts "seeded all orders for #{user.first_name}!"
end
puts 'seeded all orders!'

puts 'seeding all reviews...'
OrderDish.all.each do |order_dish|
  heads = [true, false].sample
  if heads
    Review.create!(
      order_dish: order_dish,
      content: Faker::Restaurant.review,
      rating: Faker::Number.between(from: 1, to: 5)
    )
    puts "created review for #{order_dish.dish.name} from order #{order_dish.order.id}"
  end
end
puts 'seeded all reviews!'

puts 'finished seeding!'