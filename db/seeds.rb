# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Killing users, imploding farms, cancelling tasks"
Product.destroy_all
Field.destroy_all
Task.destroy_all
Farm.destroy_all
User.destroy_all
Article.destroy_all

user = User.create!(first_name: "Natalia", last_name: "Farmer", email: "natalia.farmer@example.com",
             username: "n_farmer", password: "123456")

puts "Natalia Farmer created"
farm = Farm.create!(address: "24629 180th St, Minburn, IA 50167, United States", user: user)
puts "Farm created"

# create different tasks
# puts "Creating tasks"
# tasks = [
#   {
#     fieldOperationsType: "Tillage",
#     startDate: "2023-07-02",
#     endDate: "2023-07-02",
#     workStatus: "done",
#     farm: Farm.first,
#     crop_type: "Wheat"
#   },
#   {
#     fieldOperationsType: "Seeding",
#     startDate: "2023-07-09",
#     endDate: "2023-07-09",
#     workStatus: "planned",
#     farm: Farm.first,
#     crop_type: "Wheat"
#   },
#   {
#     fieldOperationsType: "Harvest",
#     startDate: "2023-08-16",
#     endDate: "2023-08-16",
#     workStatus: "planned",
#     farm: Farm.first,
#     crop_type: "Wheat"
#   },
#   {
#     fieldOperationsType: "Operation",
#     startDate: "2023-08-23",
#     endDate: "2023-08-23",
#     workStatus: "planned",
#     farm: Farm.first,
#     crop_type: "Wheat"
#   },
#   {
#     fieldOperationsType: "Seeding",
#     startDate: "2023-06-15",
#     endDate: "2023-06-15",
#     workStatus: "done",
#     farm: Farm.first,
#     crop_type: "Corn"
#   },
#   {
#     fieldOperationsType: "Tillage",
#     startDate: "2023-06-08",
#     endDate: "2023-06-08",
#     workStatus: "done",
#     farm: Farm.first,
#     crop_type: "Corn"
#   },
#   {
#     fieldOperationsType: "Operation",
#     startDate: "2023-06-22",
#     endDate: "2023-06-22",
#     workStatus: "done",
#     farm: Farm.first,
#     crop_type: "Corn"
#   },
#   {
#     fieldOperationsType: "Harvest",
#     startDate: "2023-08-16",
#     endDate: "2023-08-16",
#     workStatus: "planned",
#     farm: Farm.first,
#     crop_type: "Corn"
#   }
# ]
#
# tasks.each do |task|
#   Task.create!(task)
# end
# puts "Tasks created"

puts 'Creating articles'

articles = [

  {
    category: "Your Farm Update",
    author: "John Deere Operation Center",
    content: "Great news!🌾 Tilling at full throttle pays off. Your latest tillage operation achieved an impressive average speed of 4.3 mph, ensuring efficient soil preparation for optimal crop growth. Keep up the momentum and cultivate success!",
    date: "2023-07-08"
  },

  {
    category: "Guidance",
    author: "Agricultural Advisory Support",
    content: "Here's a valuable tip to optimize your experience with John Deere equipment.🚜 When it comes to tire pressure, tailoring it to match the field conditions can work wonders. Adjusting the tire pressure on your John Deere machinery based on factors like soil type, moisture levels, and load capacity can have a significant impact. By finding the right balance, you enhance traction, minimize soil compaction, and even improve fuel efficiency. So, take a moment to assess your field's needs and fine-tune those tire pressures accordingly. Your crops and equipment will thank you, ensuring a smoother ride and a bountiful harvest!",
    date: "2023-07-08",
  },

  {
    category: "Maintenance",
    author: "John Deere Notifications",
    content: " Give your Tractors some TLC!🚜 Schedule maintenance now for peak performance and extended lifespan!",
    date: "2023-07-08",
  },

  {
    category: "Weather",
    author: "Weather Central Notifications",
    content: "Storm Alert: Brace for Impact!⛈️ Secure your crops and safeguard your fields against the impending storm. Stay prepared and protect your harvest!",
    date: "2023-07-08",
  },

  {
    category: "Guidance",
    author: "Agricultural Advisory Support",
    content: "Did you know that corn crops possess a remarkable root system?🌽 Their extensive roots help improve soil structure, prevent erosion, and enhance nutrient uptake. Keep nurturing those roots for healthier and thriving cornfields!",
    date: "2023-07-08",
  },

  {
    category: "Your Farm Update",
    author: "John Deere Operation Center",
    content: "Exciting update on your recent application of 'Tank Mix' product.💨 The combination of 'Touchdown Total' (48 rate) and 'FS MaxSupreme' (32 rate) worked wonders in just 10 minutes. Your crops are set to thrive with this winning formula. Kudos on a successful application!",
    date: "2023-07-07"
  }

]

articles.each do |article|
  Article.create!(article)
end
puts "Articles created"
