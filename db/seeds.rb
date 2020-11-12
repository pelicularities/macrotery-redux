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
  "Woodlands East Industrial Estate Singapore",
  "3 QUEEN'S ROAD Singapore",
  "2 Bukit Batok Street 24 Singapore",
  "81 Marine Parade Central Singapore",
  "55 Chander Rd Singapore",
  "828 Tampines St 81 Singapore",
  "261 Waterloo St Singapore",
  "50 Kallang Ave Singapore",
  "95 Killiney Road Singapore",
  "423 Tampines St 41 Singapore",
  "209 Henderson Rd Singapore",
  "5 Tai Seng Drive Singapore",
  "24 Defu Lane 10 01-232 Singapore",
  "2 Fan Yoong Rd Singapore",
  "NO 6 TUAS AVE Singapore",
  "Katong Shopping Centre 865 Mountbatten Road Singapore",
  "492 Geylang Road Singapore",
  "546A SERANGOON ROAD Singapore",
  "1045 Eunos Ave 4 Singapore",
  "Clifford Centre 24 Raffles Place Singapore",
  "295A Tanjong Katong Road Singapore",
  "253 Alexandra Road Singapore",
  "9 Aljunied Rd Singapore",
  "41 Holland Dr Singapore",
  "1 Esplanade Drive Singapore",
  "5051 Singapore",
  "Da Jin Factory Building 362 Upper Paya Lebar Road Singapore",
  "United Square 101 Thomson Road Singapore",
  "277 ORCHARD ROAD Singapore",
  "24 Peck Seah Street Singapore",
  "Chinatown Complex (U/C) 335 Smith Street Singapore",
  "1 Queensway Singapore",
  "497 Tampines Street 45 Singapore",
  "406A Sembawang Dr Singapore",
  "115 Neythal Road Singapore",
  "18 Tuas West Avenue Singapore",
  "65 CHULIA STREET Singapore",
  "3 Pickering Street Singapore",
  "60 KIM KEAT ROAD Singapore",
  "38 Kim Tian Road Singapore",
  "566 Balestier Road Singapore",
  "Yi Xiu Factory Building 65 Sims Avenue Singapore",
  "3028A Ubi Road 3 Singapore",
  "21 Tai Seng Street Singapore",
  "43 Ubi Crescent Singapore",
  "2 Jurong East St 21 Singapore",
  "1 Yishun St 23 Singapore",
  "1 Tanjong Pagar Road Singapore",
  "416 Ang Mo Kio Ave 10 Singapore",
  "133 New Bridge Rd Singapore",
  "1 Finlayson Green Singapore",
  "Fortune Centre 190 Middle Road Singapore",
  "253 Arcadia Road Singapore",
  "BLK 3021 UBI AVENUE 2 Singapore",
  "Holland Road Shopping Centre 211 Holland Avenue Singapore",
  "BLK 18 JALAN MEMBINA Singapore",
  "1 Sophia Rd Singapore",
  "39 Ubi Road 1 Singapore",
  "817 Jurong West Street 81 Singapore",
  "19 Kallang Avenue 01-159 Singapore",
  "304 Orchard Road Singapore",
  "528 Hougang Ave 6 Singapore",
  "255 Kaki Bukit Ave 1 Singapore",
  "5B TRENGGANU STREET Singapore",
  "180 Cecil Street Singapore",
  "Tong Eng Building 101 Cecil Street Singapore",
  "192 Waterloo Street Singapore",
  "5 Shenton Way Singapore",
  "31 Pandan Road Singapore",
  "45 Defu Lane 9 Singapore",
  "77 High St Singapore",
  "55 Lorong L Telok Kurau Singapore",
  "190 Lorong 6 Toa Payoh Singapore",
  "No6 Attap Valley Road Singapore",
  "116 Changi Road Singapore",
  "PU4 PULAU UBIN Singapore",
  "435 Orchard Road Singapore",
  "33B Hongkong Street Singapore",
  "252 North Bridge Road Singapore",
  "148 Potong Pasir Ave 1 Singapore",
  "141 Cecil Street Singapore",
  "810 GEYLANG ROAD Singapore",
  "160 Changi Rd Singapore",
  "24 New Industrial Rd Singapore",
  "141 Cecil Street Singapore",
  "20 KRANJI ROAD Singapore",
  "18 MANDAI ESTATE Singapore",
  "230 Orchard Road Singapore",
  "34 Pioneer Sector 2 Singapore",
  "4 Tuas View Lane Singapore",
  "41 KALLANG PUDDING ROAD Singapore",
  "275 Thomson Rd Singapore",
  "27 Woodlands Industrial Park E 1 Singapore",
  "371 ALEXANDRA ROAD AIA ALEXANDRA Singapore",
  "215 HENDERSON ROAD Singapore",
  "1045 Eunos Ave 4 Singapore",
  "BLK 2021 BUKIT BATOK STREET 23 Singapore",
  "896 Dunearn Road Singapore",
  "466 Pasir Ris Street 41 Singapore",
  "3 Mt Elizabeth Singapore",
  "71 Tannery Lane Singapore",
  "1 Cherry Ave Singapore",
  "10 Sinaran Drive Singapore",
  "Changi Airfreight Centre P O Box 940 Singapore",
  "39 Ubi Road 1 Singapore",
  "No 8 Defu Lane 8 Singapore",
  "178 Serangoon Rd Singapore",
  "4 LORONG 13 GEYLANG Singapore",
  "24 Defu Lane 10 01-232 Singapore",
  "9008 Tampines St 93 Singapore",
  "1 North Bridge Road Singapore",
  "1003 Bukit Merah Central Singapore",
  "195 Pearl's Hill Terrace Singapore",
  "Blk 620 Choa Chu Kang St 62 06-16 Singapore",
  "221 Boon Lay Place Singapore",
  "208 Hougang Street 21 Singapore",
  "748 Yishun Street 72 01-212 Singapore",
  "Frontier 50 Ubi Avenue 3 Singapore",
  "7 RAFFLES BOULEVARD Singapore",
  "Guan Hua Warehouse Building 85 Genting Lane Singapore",
  "42 Woodlands Terrace Singapore",
  "100 Cecil Street Singapore",
  "22 Farrer Road Singapore",
  "304 ORCHARD ROAD Singapore",
  "325A Beach Road Singapore",
  "84 Geylang Bahru 01-2676 Singapore",
  "Far East Plaza 14 Scotts Road Singapore",
  "201 Pearls Hill Terrace Singapore",
  "74 Whampoa Dr Singapore",
  "BLK 115 BUKIT MERAH VIEW Singapore",
  "3791 jalan bukit merah Singapore",
  "3 Coleman Street Singapore",
  "53 Ang Mo Kio Ave 3 Singapore",
  "24 Benoi Place Singapore",
  "109 Lorong 1 Toa Payoh Singapore",
  "3 COLEMAN STREET Singapore",
  "371 Alexandra Rd Singapore",
  "55 Ayer Rajah Crescent Singapore",
  "361 UBI ROAD 3 Singapore",
  "278 SOUTH BRIDGE ROAD Singapore",
  "11 Tuas Ave 3 Singapore",
  "6 Napier Rd Singapore",
  "20 Kramat Lane Singapore",
  "16 CHANGI SOUTH STREET 1 Singapore",
  "Block 5002 Ang Mo Kio Avenue 5 Singapore",
  "Tampines St 41  Tampines Singapore",
  "41 Toh Guan Road East Singapore",
  "801 French Road Singapore",
  "180 Paya Lebar Rd Singapore",
  "344A Joo Chiat Road Singapore",
  "1 Kim Seng Promenade Singapore",
  "3020 UBI AVENUE 2 02-119 Singapore",
  "57 Geylang Bahru Singapore",
  "21 Middle Rd Singapore",
  "545 Orchard Road Singapore",
  "252 North Bridge Road Singapore",
  "58 Amoy St Singapore",
  "2 Pandan Valley Singapore",
  "1 Fullerton Square Singapore",
  "1 Woodlands Square Singapore",
  "20 Maxwell Road Singapore",
  "62 Tannery Lane Singapore",
  "Cecil Street Singapore",
  "221 Boon Lay Place Singapore",
  "2A Sungei Kadut Drive Singapore",
  "252 North Bridge Road Singapore",
  "14 Everton Road Singapore",
  "2 DEFU LANE 8 Singapore",
  "3025 Ubi Road 3 Singapore",
  "1 Raffles Place Singapore",
  "482 Admiralty Link Singapore",
  "214 Upper East Coast Road Singapore",
  "9 Battery Rd Singapore",
  "300 Beach Road Singapore",
  "63 CHULIA STREET Singapore",
  "1090 Lower Delta Road Singapore",
  "304 Orchard Rd Singapore",
  "BLK 64 YUNG KUANG ROAD Singapore",
  "57 Geylang Bahru Singapore",
  "31 Defu Lane 10 Singapore",
  "277 ORCHARD ROAD Singapore",
  "36 Robinson Road Singapore",
  "2 Ang Mo Kio St 64 Singapore",
  "180 Tyrwhitt Rd Singapore",
  "26 Belimbing Ave Singapore",
  "10-12 SCOTTS ROAD Singapore",
  "13 Pandan Crescent Singapore",
  "621 Hougang Ave 8 Singapore",
  "3020 Ubi Avenue 2 Singapore",
  "219 Henderson Road Henderson Industrial Park Singapore",
  "3188 Geylang Bahru Singapore",
  "48 Tuas Road Singapore",
  "1 Changi North Street 1 Singapore",
  "3 South Buona Vista Road Singapore",
  "21 Marsiling Lane Singapore",
  "55 Lorong L Telok Kurau Singapore",
  "53 Ubi Ave 1 Singapore",
  "29 RECREATION LANE Singapore",
  "52B Temple Street Singapore",
  "13 SIGLAP ROAD Singapore",
  "58 Jalan Tari Piring Singapore",
  "71B DUXTON ROAD Singapore",
  "5 Kian Teck Road Singapore",
  "27 Purvis Street Singapore",
  "160 Ang Mo Kio Ave 4 Singapore",
  "Telok Blangah House 52 Telok Blangah Road Singapore",
  "22 Tai Gin Rd Singapore",
  "60 Albert Street Singapore",
  "Sim Lim Square 1 Rochor Canal Road Singapore",
  "141 Middle Road Singapore",
  "135 JALAN BESAR Singapore",
  "1 Ridgewood Close Singapore",
  "9 HAIG LANE Singapore",
  "10 Sinaran Drive Singapore",
  "48 Toh Guan Rd East Singapore",
  "59 Ubi Ave 1 Singapore",
  "20 Watten Rise Singapore",
  "1 Maritime Square Singapore",
  "394 Upper Bukit Timah Road Singapore",
  "2 Sungei Kadut Street 3 Singapore",
  "35/37 CUPPAGE ROAD Singapore",
  "35 Changi South Singapore",
  "157 Sin MIng Road Singapore",
  "106 Yishun Ring Road Singapore",
  "1009 Tai Seng Ave Singapore",
  "11 Chin Bee Drive Singapore",
  "6 Soon Lee Road Jurong Singapore",
  "517 Airport Road Singapore",
  "912 Upper Thomson Road Singapore",
  "201D Tampines Street 21 Singapore",
  "112 Robinson Road Singapore",
  "37 Ann Siang Road Singapore",
  "16 Collyer Quay Singapore",
  "21 Anderson Rd Singapore",
  "BLK 38 DEFU LANE 10 Singapore",
  "82 HORNE ROAD Singapore",
  "31 Defu Lane 10 Singapore",
  "Woodlands Singapore",
  "45 Craig Rd Singapore",
  "10 Collyer Quay Singapore",
  "3013 Bedok North Avenue 4 Singapore",
  "101 Lor 23 Geylang Singapore",
  "1 Maritime Square Singapore",
  "391 B Orchard Road Singapore",
  "2 Soon Wing Road Singapore",
  "222 PASIR PANJANG ROAD Singapore",
  "4 Penjuru Close Singapore",
  "1001 Jalan Bukit Merah Singapore",
  "8 Temasek Boulevard Singapore",
  "1 Raffles Place Singapore",
  "10 Anson Road Singapore",
  "787B Choa Chu Kang Drive Singapore",
  "60 COLLYER QUAY Singapore",
  "896 Dunearn Road Singapore",
  "150F East Coast Road Singapore",
  "511 Upper Jurong Road Singapore",
  "3 Anson Road Singapore",
  "2 Jurong East St 21 Singapore",
  "53 Ubi Ave 1 Singapore",
  "50 Gul Avenue Singapore",
  "177 Toa Payoh Central Singapore",
  "11 DEFU LANE 10 DEFU INDUSTRIAL PARK C Singapore",
  "261 Waterloo St Singapore",
  "2 Tampines Central 5 Singapore",
  "321 Orchard Road Singapore",
  "36 Sungei Kadut Street 2 Sungei Kadut Industrial Estate Singapore",
  "350 Orchard Road Singapore",
  "152 Beach Road Singapore",
  "361 JOO CHIAT PL Singapore",
  "Balmoral Plaza 271 Bukit Timah Road Singapore",
  "18A Murray Street Singapore",
  "1 Pasir Ris Cl Singapore",
  "72A Dunlop Street Singapore",
  "4 Shenton Way Singapore",
  "11 King Albert Park Singapore",
  "29A Jalan Selamat Singapore",
  "42 Woodlands Terrace Singapore",
  "2 Jurong East Street 21 Singapore",
  "80 Raffles PI Singapore",
  "52 Genting Lane Singapore",
  "2 RAFFLES LINK Singapore",
  "16 Jalan Kilang Timor Singapore",
  "10 Tuas View Square Singapore",
  "55 Siglap Rd Singapore",
  "7500A Beach Road 16-316 The Plaza Singapore",
  "2A Kian Teck Avenue Singapore",
  "1 Kaki Bukit Road 1 Singapore",
  "5 Ang Mo Kio Industrial Park 2a Singapore",
  "422 Orchard Road Singapore",
  "100 Beach Road Singapore",
  "389 BALESTIER ROAD Singapore",
  "6001 Beach Road Singapore",
  "55 Market Street Singapore",
  "63 Cantonment Road Singapore",
  "164 Lentor Loop Singapore",
  "13 Short Street Singapore",
  "2 PEGU ROAD Singapore",
  "30 Upper Cross Street Singapore",
  "219 Henderson Road Singapore",
  "3A River Valley Road Singapore",
  "LOT 52 SUNGEI TENGAH ROAD Singapore",
  "2 Finlayson Green Singapore",
  "13A Pandan Crescent   singapore Singapore",
  "80 Marine Parade Rd Singapore",
  "35 Selegie Road Singapore",
  "170 Ghim Moh Rd Singapore",
  "54 SMITH ST Singapore",
  "6 Eu Tong Sen St Singapore",
  "77 High St Singapore",
  "16 16 Woodlands Walk Singapore",
  "Pioneer Road North Singapore",
  "1 Jurong West Central 2 Singapore",
  "8A Jetty Rd Singapore",
  "7 CLUB STREET Singapore",
  "30 Robertson Quay Singapore",
  "10 Hoe Chiang Road Singapore",
  "513 Bishan Street 13 01-514 Singapore",
  "357D Holland Road Singapore",
  "304 ORCHARD ROAD Singapore",
  "273B New Bridge Road  Chinatown Singapore",
  "25 Genting Road Singapore",
  "9 Jurong Town Hall Road Singapore",
  "180 Paya Lebar Road Singapore",
  "12 Soon Lee Road Singapore",
  "14 Prince George's Park Singapore",
  "123 Genting Lane Singapore",
  "6 Temasek Boulevard Singapore",
  "18 Pearls Hill Terrace Singapore",
  "141 Cecil Street Singapore",
  "7 Temasek Blvd Singapore",
  "140 UPPER BUKIT TIMAH ROAD Singapore",
  "111 North Bridge Road Singapore",
  "127 Pioneer Road Singapore",
  "196 Pandan Loop Singapore",
  "1 George Street Singapore",
  "13 Short Street Singapore",
  "317 Joo Chiat Road Singapore",
  "5 Koek Road Singapore",
  "150 Orchard Road Orchard Plaza Singapore",
  "94 ENG NEO AVENUE Singapore",
  "12 TRENGGANU STREET Singapore",
  "8 Bukit Pasoh Road Singapore",
  "15 Lorong 8 Toa Payoh 04-06 Singapore",
  "14 Senoko Loop Singapore",
  "2030 Bukit Batok Street 23 Singapore",
  "3 Science Park Drive Singapore",
  "BLK 114 BUKIT BATOK WEST AVENUE 6 Singapore",
  "4D Marigold Dr Singapore",
  "8 Temasek Boulevard Singapore",
  "BLK 10 PASIR PANJANG ROAD Singapore",
  "39 Kim Chuan Drive Singapore",
  "3027 Ubi Road 1 Singapore",
  "11 COLLYER QUAY Singapore",
  "1009 Tai Seng Ave Singapore",
  "205 Henderson Road Singapore",
  "253 Alexandra Road Singapore",
  "18 Boon Lay Way Singapore",
  "61 Killiney Road Singapore",
  "80 Anson Road Singapore",
  "111 NORTH BRIDGE ROAD Singapore",
  "427 Race Course Road Singapore",
  "Guan Hua Warehouse Building 85 Genting Lane Singapore",
  "302 Tiong Bahru Rd Singapore",
  "60 Robertson Quay Singapore",
  "100 Namly Ave Singapore",
  "391 Orchard Road Singapore",
  "774 Woodlands Crescent Singapore",
  "61 Kaki Bukit Avenue 1 Singapore",
  "865 MOUNTBATTEN ROAD Singapore",
  "10 Anson Road Singapore",
  "10 Ubi Crescent Singapore",
  "132A Telok Ayer St Singapore",
  "Pasir Ris Singapore",
  "303 Changi Rd Singapore",
  "15 Scotts Road Singapore",
  "1 Yishun St 23 Singapore",
  "4 Robinson Rd Singapore",
  "International Plaza 10 Anson Road Singapore",
  "21 Orchard Boulevard Singapore",
  "13 Haig Road 01-002 Singapore",
  "8 Senoko Sth Rd Singapore",
  "2 JALAN TERUSAN Singapore",
  "1090 Lower Delta Rd Singapore",
  "204 SYED ALWI ROAD Singapore",
  "BLK 148 POTONG PASIR AVENUE 1 Singapore",
  "Delfi Orchard 402 Orchard Road Singapore",
  "111 North Bridge Rd Singapore",
  "30 Robertson Quay Singapore",
  "42 Surin Avenue Singapore",
  "354 Clementi Ave 2 Singapore",
  "Woodlands Singapore",
  "62 Tannery Lane Singapore",
  "8 Lorong Bakar Batu 01-04 Singapore",
  "112 Middle Rd Singapore",
  "5001 Beach Rd Singapore",
  "10 Ubi Crescent Singapore",
  "1 NORTH BRIDGE ROAD Singapore",
  "828 Tampines Street 81 Singapore",
  "42 Horne Rd Singapore",
  "2 Jurong East Street 21 Singapore",
  "401 HAVELOCK ROAD Singapore",
  "15 MCCALLUM STREET Singapore",
  "19 Tanglin Rd Singapore",
  "LHK Building 701 Sims Drive Singapore",
  "116 CHANGI ROAD Singapore",
  "56 Upavon Road Singapore",
  "54 SENOKO ROAD Singapore",
  "36 Robinson Road Singapore",
  "24 Lorong Pisang Raja Singapore",
  "391B Orchard Road Singapore",
  "Pioneer Road North Singapore",
  "42C HONGKONG STREET Singapore",
  "11 Tai Thong Crescent Singapore",
  "120 Maxwell Road Singapore",
  "118 Depot Lane Singapore",
  "263 Serangoon Central Dr Singapore",
  "1 Selegie Road Singapore",
  "1 Yishun St 23 Singapore",
  "400 Orchard Road Singapore",
  "80 Raffles PI Singapore",
  "43 Carpenter Street Singapore",
  "1 SELEGIE ROAD Singapore",
  "118 Taman Permata Singapore",
  "180 ORCHARD ROAD Singapore",
  "3 Miller Street Singapore",
  "587 Bukit Timah Road Singapore",
  "19 FISHERY PORT ROAD Singapore",
  "2 Pioneer Sector Lane Singapore",
  "1003 Yishun Industrial Park A Singapore",
  "20 LEEDON HEIGHTS B1-01 Singapore",
  "M25 OLD LIM CHU KANG ROAD Singapore",
  "Parkway Parade 80 Marine Parade Road Singapore",
  "12 Norris Road Singapore",
  "29 SENOKO LOOP Singapore",
  "9 Sungei Kadut Crescent Singapore",
  "21 Orchard Boulevard Singapore",
  "9 Jalan Seh Chuan Singapore",
  "10 Anson Road Singapore",
  "Peninsula Plaza 111 North Bridge Road Singapore",
  "180 Cecil Street Singapore",
  "194 Pandan Loop Singapore",
  "189 Syed Alwi Road Singapore",
  "9010 Tampines St 93 Singapore",
  "391B Orchard Road Singapore",
  "30 WATTEN DRIVE Singapore",
  "416 Ang Mo Kio Ave 10 Singapore",
  "99A TANJONG PAGAR ROAD Singapore",
  "Sim Lim Square 1 Rochor Canal Road Singapore",
  "51 Ubi Ave 1 Singapore",
  "180C JOO CHIAT RD Singapore",
  "400 Orchard Road Singapore",
  "Blk 531 Up Cross St Singapore",
  "192 Pandan Loop Singapore",
  "246 TANJONG KATONG ROAD Singapore",
  "10 Anson Road Singapore",
  "5057 Ang Mo Kio Industrial Park 2 Singapore",
  "26 Kallang Place Singapore",
  "BLK 16 UPPER BOON KENG ROAD Singapore",
  "7 Kian Teck Crescent Singapore",
  "The Regent  One Cuscaden Road Singapore",
  "10 Genting Road Singapore",
  "BLK 205 BEDOK NORTH STREET 1 Singapore",
  "11 Keng Cheow Street Singapore",
  "Blk 4 Queen's Rd Singapore",
  "100 Jalan Sultan Singapore",
  "14 Senoko Loop Singapore",
  "Orchard Point 160 Orchard Road Singapore",
  "10 Jalan Besar Singapore",
  "3 Anson Road Singapore",
  "19 Benoi Crescent Singapore",
  "467 HOUGANG AVENUE 8 05-1516 Singapore",
  "1 Selegie Road Singapore",
  "10 Anson Road International Plaza Singapore",
  "1045 Eunos Ave 4 Singapore",
  "29 Tuas Avenue 8 Singapore",
  "6 RAFFLES BOULEVARD Singapore",
  "896 Dunearn Rd Singapore",
  "55 Market Street Singapore",
  "65 Chulia Street Singapore",
  "224 Loyang Avenue Singapore",
  "10 Ubi Crescent Singapore",
  "1 Jalan Anak Bukit Singapore",
  "15 Defu Lane 7 Singapore",
  "Yishun Ring Road Singapore",
  "277 ORCHARD ROAD Singapore",
  "1D Yong Siak Street Singapore",
  "5 Shenton Way Singapore",
  "46 South Bridge Road Singapore",
  "24 Raffles Place Singapore",
  "150 Cecil Street Singapore",
  "1 Pasir Ris Cl Singapore",
  "3 Mount Elizabeth MEDICAL CTR Singapore",
  "470 Pasir Ris Dr 6 Singapore",
  "3 Jalan Lengkok Sembawang Singapore",
  "32 Jalan Rajah Singapore"  
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
