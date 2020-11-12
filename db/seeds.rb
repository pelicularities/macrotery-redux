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

puts "seeding demo user.."
users = [
  {
    email: 'demo@demo.com',
    password: 'demo12345',
    first_name: 'Demo',
    last_name: 'User',
    phone_number: '12345678',
    protein: 150,
    carbs: 200,
    fats: 60
  }
]
users.each do |user|
  User.create!(user)
  puts "seeded user #{user[:email]}"
end
puts 'users seeded!'

#######
# TODO
#######
# seeded user meals should include
# one for "cheat day" -- med protein, high carbs, high fat
# one for "normal meal" - med protein, med carbs, low fat
# one for "post-workout meal" - high protein, med carbs, low fat
# one for "marathon training" - med protein, high carbs, low fat

puts 'seeding user meals...'
User.all.each do |user|
  meal_seeds = [
    {
      name: 'Normal',
      protein: 40,
      carbs: 80,
      fats: 30
    },
    {
      name: 'Post-Workout Meal',
      protein: 80,
      carbs: 80,
      fats: 30
    },
    {
      name: 'Marathon Training',
      protein: 50,
      carbs: 120,
      fats: 20
    },
    {
      name: 'Cheat Meal',
      protein: 30,
      carbs: 120,
      fats: 60
    }
  ]
  meal_seeds.each do |meal|
    new_meal = Macro.new(meal)
    new_meal.user = user
    new_meal.save
    puts "seeded #{user.first_name}'s #{meal[:name]}"
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

############
# TODO
############
# should have eateries all across SG
# Orchard eateries should have nice logos
# Orchard eateries' food images should match their names
# Orchard eateries' food macros should match their names
# Orchard eateries' prices should match their names
# not using description any more
# There should be one eatery nearby (at 350 Orchard Road? Shaw?)
# that has a meal that matches the diabetic, strength athlete and cheat meal profiles

puts 'seeding eateries...'
addresses = [
  "360 ORCHARD ROAD Singapore",
  "45 HAJI LANE Singapore",
  "11 Collyer Quay Singapore",
  "Jervois Rd Singapore",
  "6 Lakme St Singapore",
  "Pasir Ris Singapore",
  "140A Sims Ave Singapore",
  "13 Tuas Link 1 Singapore",
  "BLK 19 MARSILING LANE Singapore",
  "18 Toh Yi Drive Singapore",
  "5 LORONG 21 GEYLANG Singapore",
  "3 Temasek Blvd Singapore",
  "1080 Eunos Avenue 7 01-161 Singapore",
  "1 Maritime Square 01-111 Singapore",
  "78A Telok Blangah Street 32 Singapore",
  "31 Gul Drive Singapore",
  "83 Genting Lane Singapore",
  "10 BUKIT CHERMIN ROAD Singapore",
  "2 Kallang Pudding Rd Singapore",
  "BLK 44 HOLLAND DRIVE Singapore",
  "Textile Centre 200 Jalan Sultan Singapore",
  "100 Beach Road Singapore",
  "Millenia Tower 1 Temasek Avenue Singapore",
  "3018 Bedok North Street 5 Singapore",
  "130 Tanjong Rhu Road Singapore",
  "51 Bras Basah Road Singapore",
  "170 Upper Bukit Timah Road Singapore",
  "383 Sin Ming Dr Singapore",
  "605B Macpherson Road Singapore",
  "2 Balestier Road Singapore",
  "150 Kampong Ampat Singapore",
  "SENG POH ROAD Singapore",
  "6 Napier Rd Singapore",
  "High Street High Street Plaza Singapore",
  "001 Casuarina Road Rd Singapore",
  "101 Kitchener Rd Singapore",
  "3 Phillip Street Singapore",
  "65 CHULIA STREET Singapore",
  "43 Lorong 34 Geylang Singapore",
  "687A Choa Chu Kang Dr Singapore",
  "The Adelphi 1 Coleman Street Singapore",
  "Bugis Junction 230 Victoria Street Singapore",
  "1 North Bridge Road Singapore",
  "1 Keong Saik Rd Singapore",
  "Ion Orchard 2 Orchard Turn Singapore",
  "54 SENOKO ROAD Singapore",
  "4 Robinson Rd Singapore",
  "74 Amoy St Singapore",
  "20 Bideford Road Singapore",
  "39 Lorong 24 Geylang Singapore",
  "12 Gul Drive Singapore",
  "103 Amoy Street Singapore",
  "33 Tembeling Road Singapore",
  "31A Cantonment Road Singapore",
  "Bugis Junction 200 Victoria Street Singapore",
  "3 COLEMAN STREET Singapore",
  "406A Sembawang Dr Singapore",
  "112D Oxley Rise Singapore",
  "BLK 107 SERANGOON NORTH AVENUE 1 Singapore",
  "1074 Eunos Avenue 6 Singapore",
  "Far East Plaza 14 Scotts Road Singapore",
  "2022 Bukit Batok Street 23 Singapore",
  "35 Selegie Road Singapore",
  "152 Beach Road Singapore",
  "420 North Bridge Road Singapore",
  "73 Science Park Drive Singapore",
  "Maxwell House 20 Maxwell Road Singapore",
  "478 River Valley Rd Singapore",
  "123B Serangoon Road Singapore",
  "629 Aljunied Road Singapore",
  "3 MOUNT ELIZABETH Singapore",
  "11 COLLYER QUAY Singapore",
  "80 Marine Parade Rd Singapore",
  "9 Temasek Boulevard Singapore",
  "133 Cecil Street Singapore",
  "127 Pioneer Road Singapore",
  "182 Tagore Lane Singapore",
  "6 Soon Lee Road Jurong Singapore",
  "190 Yishun Avenue 7 Singapore",
  "231 Lavender St Singapore",
  "159 STILL ROAD Singapore",
  "908A Upper Thomson Road Singapore",
  "21 Serangoon North Ave 5 Singapore",
  "4 Kwong Min Road Singapore",
  "63 Market St Singapore",
  "39 Gul Drive Singapore",
  "27 PURVIS STREET Singapore",
  "Shaw Centre 1 Scotts Road Singapore",
  "9 holland avenue 20-62 Singapore",
  "16 Raffles Quay Singapore",
  "31 Loyang Crescent Singapore",
  "20 Cecil Street Singapore",
  "BLK 7 JALAN BATU Singapore",
  "210 Turf Club Road Singapore",
  "170 UPPER BUKIT TIMAH ROAD Singapore",
  "Boon Lay Shopping Centre 221 Boon Lay Place Singapore",
  "65 Sims Ave Singapore",
  "BLK 44 HOLLAND DRIVE Singapore",
  "Pioneer Road North Singapore",
  "238A Thomson Road Singapore",
  "5040 Ang Mo Kio Ind Pk 2 Singapore",
  "60 Eng Kong Place Singapore",
  "34 Marine Cres Singapore",
  "5 Ang Mo Kio Ind Pk 2A Singapore",
  "46A Tuas Crescent Singapore",
  "10 HONGKONG STREET Singapore",
  "1 Joo Chiat Road Singapore",
  "6 Marsiling Lane Singapore",
  "33 Tuas South Street 1 Singapore",
  "Woodlands East Industrial Estate Singapore"
]

logos = [
  'https://res.cloudinary.com/graceteng/image/upload/v1601565848/000_lettuce_leaf_logo_twcvho.png',
  'https://res.cloudinary.com/graceteng/image/upload/v1601565825/tea_logo_hxcubc.png',
  'https://res.cloudinary.com/graceteng/image/upload/v1601565847/000_ox_tales_logo_rlot9r.png',
  'https://res.cloudinary.com/graceteng/image/upload/v1601565848/000_pincer_movement_logo_ovx94l.png',
  'https://res.cloudinary.com/graceteng/image/upload/v1601565848/000_go_fish_logo_qcfrum.png',
]

names = [
  'The Lettuce Leaf',
  'Tea.',
  'Ox Tales',
  'Pincer Movement',
  'Go Fish'
]

addresses.each_with_index do |address, index|
  modulo = index % names.count

  eatery = Eatery.new
  eatery.name = names[modulo]
  eatery.address = address
  eatery.phone_number = "6#{Faker::Number.number(digits: 7)}"
  eatery.description = Faker::Restaurant.description
  eatery.save!

  file = URI.open(logos[modulo])
  content_type = "image/#{logos[modulo][-3, 3]}"
  eatery.photo.attach(io: file, filename: "logo#{index}.png", content_type: content_type)

  puts "seeded #{eatery.name}"
end
puts 'eateries seeded!'

puts 'seeding eatery-cuisine relationship...'
Eatery.all.each do |eatery|
  2.times do
    until eatery_cuisine = EateryCuisine.create(eatery: eatery, cuisine: Cuisine.all.sample)
      puts "finding a suitable cuisine for #{eatery.name}..."
    end
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



# Eatery.all.each do |eatery|
#   next if names[0, 5].include?(eatery.name)
#   10.times do
#     dish = Dish.new
#     dish.eatery = eatery
#     dish.name = Faker::Food.unique.dish
#     dish.price_cents = rand(100..4000)
#     dish.protein = Faker::Number.between(from: 10, to: 60)
#     dish.carbs = Faker::Number.between(from: 40, to: 120)
#     dish.fats = Faker::Number.between(from: 15, to: 50)
#     dish.description = Faker::Food.description
#     dish.save!

#     dish_image = dish_images.sample
#     file = URI.open(dish_image)
#     dish.photo.attach(io: file, filename: "dish#{dish.id}.png", content_type: 'image/png')

#     puts "seeded dish #{dish.name}"
#   end
#   puts "seeded dishes for #{eatery.name}!"
#   Faker::Food.unique.clear
# end

lettuce_leaf_dishes = [
  {
    name: 'Caesar Salad',
    price_cents: 790,
    protein: 5,
    carbs: 10,
    fats: 14
  },
  {
    name: 'Impossible Salad',
    price_cents: 1290,
    protein: 17,
    carbs: 11,
    fats: 14
  },
  {
    name: 'Garden Salad',
    price_cents: 590,
    protein: 2,
    carbs: 10,
    fats: 5
  },
  {
    name: 'Tuna Salad',
    price_cents: 990,
    protein: 23,
    carbs: 7,
    fats: 15
  },
  {
    name: 'Shrimp Salad',
    price_cents: 990,
    protein: 16,
    carbs: 8,
    fats: 16
  },
  {
    name: 'Niçoise Salad',
    price_cents: 1090,
    protein: 27,
    carbs: 24,
    fats: 7
  }
]
lettuce_leaf_images = [
  'https://source.unsplash.com/R4QckNsg0sw',
  'https://source.unsplash.com/oj2hBf5TOFM',
  'https://source.unsplash.com/RNmibnLCJAA',
  'https://source.unsplash.com/ZwzZ5F_pIBU',
  'https://source.unsplash.com/w_z0RJCSBiE',
  'https://source.unsplash.com/PeyzQt7tMk0'
]
tea_dishes = [
  {
    name: 'Blueberry Cheesecake',
    price_cents: 1290,
    protein: 17,
    carbs: 93,
    fats: 52
  },
  {
    name: 'Burnt Cheesecake',
    price_cents: 1890,
    protein: 13,
    carbs: 111,
    fats: 55
  },
  {
    name: 'Scones',
    price_cents: 490,
    protein: 7,
    carbs: 45,
    fats: 16
  },
  {
    name: 'Signature Cupcake',
    price_cents: 690,
    protein: 3,
    carbs: 48,
    fats: 13
  },
  {
    name: 'Signature Hot Chocolate',
    price_cents: 650,
    protein: 10,
    carbs: 40,
    fats: 18
  },
  {
    name: 'Macaron',
    price_cents: 300,
    protein: 4,
    carbs: 28,
    fats: 11
  }
]
tea_images = [
  'https://source.unsplash.com/EbRBhZ-I_p8',
  'https://source.unsplash.com/xVLJ-JFTcQE',
  'https://source.unsplash.com/Kgcc8TKKEkg',
  'https://source.unsplash.com/UaeVmc51Ttw',
  'https://source.unsplash.com/MjZq7A2RJxQ',
  'https://source.unsplash.com/hV1gChgMa-k'
]
ox_tales_dishes = [
  {
    name: 'Beef Stew',
    price_cents: 1450,
    protein: 44,
    carbs: 33,
    fats: 37
  },
  {
    name: 'Beef Noodles',
    price_cents: 850,
    protein: 34,
    carbs: 48,
    fats: 28
  },
  {
    name: 'Beef Fried Rice',
    price_cents: 1450,
    protein: 48,
    carbs: 79,
    fats: 28
  },
  {
    name: 'Beef Burger',
    price_cents: 1750,
    protein: 33,
    carbs: 87,
    fats: 47
  },
  {
    name: 'Beef Steak',
    price_cents: 2850,
    protein: 39,
    carbs: 10,
    fats: 26
  },
  {
    name: 'Beef Tacos',
    price_cents: 1250,
    protein: 35,
    carbs: 27,
    fats: 25
  }
]
ox_tales_images = [
  'https://source.unsplash.com/xKSRpUH0VZo',
  'https://source.unsplash.com/l3Mr7vSdmd4',
  'https://source.unsplash.com/v8B1gN_QUbI',
  'https://source.unsplash.com/4hgYULBzVEE',
  'https://source.unsplash.com/ZLj6aVacbFo',
  'https://source.unsplash.com/z_PfaGzeN9E'
]
pincer_movement_dishes = [
  {
    name: 'Oysters',
    price_cents: 1890,
    protein: 79,
    carbs: 29,
    fats: 14
  },
  {
    name: 'Lobsters',
    price_cents: 2290,
    protein: 60,
    carbs: 5,
    fats: 3
  },
  {
    name: 'Squid with Ink',
    price_cents: 890,
    protein: 33,
    carbs: 2,
    fats: 8,
  },
  {
    name: 'Grilled Salmon',
    price_cents: 1190,
    protein: 38,
    carbs: 12,
    fats: 21,
  },
  {
    name: 'Grilled Prawns',
    price_cents: 990,
    protein: 46,
    carbs: 5,
    fats: 17,
  },
  {
    name: 'Mud Crab',
    price_cents: 1590,
    protein: 28,
    carbs: 2,
    fats: 2
  }
]
pincer_movement_images = [
  'https://source.unsplash.com/f7v_NofUBx0',
  'https://source.unsplash.com/OrTjocYe1b4',
  'https://source.unsplash.com/yArvCsvY_kM',
  'https://source.unsplash.com/bpPTlXWTOvg',
  'https://source.unsplash.com/TqOEGdRNowY',
  'https://source.unsplash.com/rXDCb-Bmgdg'
]
go_fish_dishes = [
  {
    name: 'Tuna Nigiri Sushi',
    price_cents: 950,
    protein: 40,
    carbs: 40,
    fats: 10
  },
  {
    name: 'Salmon Sashimi',
    price_cents: 1350,
    protein: 60,
    carbs: 2,
    fats: 20
  },
  {
    name: 'Philadelphia Roll',
    price_cents: 1350,
    protein: 28,
    carbs: 56,
    fats: 24
  },
  {
    name: 'Unagi Avocado Roll',
    price_cents: 1350,
    protein: 18,
    carbs: 76,
    fats: 14
  },
  {
    name: 'Sushi Platter',
    price_cents: 1850,
    protein: 40,
    carbs: 78,
    fats: 29
  },
  {
    name: 'Sashimi Platter',
    price_cents: 2250,
    protein: 117,
    carbs: 19,
    fats: 47
  }
]
go_fish_images = [
 'https://source.unsplash.com/F7lk3ju2ifQ',
  'https://source.unsplash.com/53_R7KNQ1WU',
  'https://source.unsplash.com/-1GEAA8q3wk',
  'https://source.unsplash.com/InCMGusiAvA',
  'https://source.unsplash.com/5KS7T3Gs3CA',
  'https://source.unsplash.com/JnFGgVaFpmE'
]

presentation_eateries = {
  names[0] => {
    dishes: lettuce_leaf_dishes,
    images: lettuce_leaf_images
  },
  names[1] => {
    dishes: tea_dishes,
    images: tea_images
  },
  names[2] => {
    dishes: ox_tales_dishes,
    images: ox_tales_images
  },
  names[3] => {
    dishes: pincer_movement_dishes,
    images: pincer_movement_images
  },
  names[4] => {
    dishes: go_fish_dishes,
    images: go_fish_images
  }
}
presentation_eateries.keys.each do |key|
  puts key
end

Eatery.all.each do |eatery|
  eatery_name = eatery.name
  puts eatery_name
  puts presentation_eateries[eatery_name]
  presentation_eateries[eatery_name][:dishes].each_with_index do |dish, index|
    new_dish = Dish.new(dish)
    new_dish.eatery = eatery
    new_dish.description = Faker::Food.description
    new_dish.save!

    dish_image = presentation_eateries[eatery_name][:images][index]
    file = URI.open(dish_image)
    new_dish.photo.attach(io: file, filename: "dish#{new_dish.id}.png", content_type: 'image/png')
    puts "seeded #{new_dish.name}!"
  end
  puts "seeded all dishes for #{eatery_name}!"
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
    random_presentation_eatery = names[0, 5].sample
    eatery = Eatery.find_by name: random_presentation_eatery
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
