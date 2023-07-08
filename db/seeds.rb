# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Killing users, imploding farms, cancelling tasks"
Task.destroy_all
Farm.destroy_all
User.destroy_all
Article.destroy_all

user = User.create!(first_name: "Jeanne", last_name: "Farmer", email: "jeanne.farmer@example.com",
             username: "j_farmer", password: "123456")

puts "Jeanne Farmer created"
farm = Farm.create!(address: "400 Chemin Des Pins, 26260 Saint Donat Sur L'Herbasse, France", user: user)
puts "Farm created"

# create different tasks
puts "Creating tasks"
tasks = [
  {
    fieldOperationsType: "Tillage",
    startDate: "2023-07-02",
    endDate: "2023-07-02",
    workStatus: "done",
    farm: Farm.first,
    crop_type: "Wheat"
  },
  {
    fieldOperationsType: "Seeding",
    startDate: "2023-07-09",
    endDate: "2023-07-09",
    workStatus: "planned",
    farm: Farm.first,
    crop_type: "Wheat"
  },
  {
    fieldOperationsType: "Harvest",
    startDate: "2023-08-16",
    endDate: "2023-08-16",
    workStatus: "planned",
    farm: Farm.first,
    crop_type: "Wheat"
  },
  {
    fieldOperationsType: "Operation",
    startDate: "2023-08-23",
    endDate: "2023-08-23",
    workStatus: "planned",
    farm: Farm.first,
    crop_type: "Wheat"
  },
  {
    fieldOperationsType: "Seeding",
    startDate: "2023-06-15",
    endDate: "2023-06-15",
    workStatus: "done",
    farm: Farm.first,
    crop_type: "Corn"
  },
  {
    fieldOperationsType: "Tillage",
    startDate: "2023-06-08",
    endDate: "2023-06-08",
    workStatus: "done",
    farm: Farm.first,
    crop_type: "Corn"
  },
  {
    fieldOperationsType: "Operation",
    startDate: "2023-06-22",
    endDate: "2023-06-22",
    workStatus: "done",
    farm: Farm.first,
    crop_type: "Corn"
  },
  {
    fieldOperationsType: "Harvest",
    startDate: "2023-08-16",
    endDate: "2023-08-16",
    workStatus: "planned",
    farm: Farm.first,
    crop_type: "Corn"
  }
]

tasks.each do |task|
  Task.create!(task)
end
puts "Tasks created"

puts 'Creating articles'

articles = [
  {
    category: "Maintenance Alert",
    author: "John Deere Notifications",
    content: " Give your Tractors some TLC! Schedule maintenance now for peak performance and extended lifespan!",
    date: "2023-07-08",
  },

  {
    category: "Weather Alert",
    author: "Weather Central Notifications",
    content: "Storm Alert: Brace for Impact! Secure your crops and safeguard your fields against the impending storm. Stay prepared and protect your harvest!",
    date: "2023-07-08",
  },

  {
    category: "Science facts",
    author: "Facts",
    content: "Did you know that corn crops possess a remarkable root system? Their extensive roots help improve soil structure, prevent erosion, and enhance nutrient uptake. Keep nurturing those roots for healthier and thriving cornfields!",
    date: "2023-07-08",
  }
]

articles.each do |article|
  Article.create!(article)
end
puts "Articles created"
