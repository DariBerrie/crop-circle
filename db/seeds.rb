# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Destroying user and farms"
Product.destroy_all
Field.destroy_all
Farm.destroy_all
User.destroy_all

user = User.create!(first_name: "Jeanne", last_name: "Farmer", email: "jeanne.farmer@example.com",
             username: "j_farmer", password: "123456")

puts "Jeanne Farmer created"
farm = Farm.create!(address: "400 Chemin Des Pins, 26260 Saint Donat Sur L'Herbasse, France", user: user)
field = Field.create!(farm: farm)
Product.create!(category: "Peaches", harvested_at: DateTime.new(2022,7,5), harvest: 65, field: field)
Product.create!(category: "Peaches", harvested_at: DateTime.new(2022,7,11), harvest: 77, field: field)
Product.create!(category: "Peaches", harvested_at: DateTime.new(2022,7,18), harvest: 85, field: field)
Product.create!(category: "Peaches", harvested_at: DateTime.new(2022,7,25), harvest: 90, field: field)
Product.create!(category: "Peaches", harvested_at: DateTime.new(2023,7,5), harvest: 50, field: field)
Product.create!(category: "Peaches", harvested_at: DateTime.new(2023,7,11), harvest: 77, field: field)
Product.create!(category: "Peaches", harvested_at: DateTime.new(2023,7,18), harvest: 82, field: field)
Product.create!(category: "Peaches", harvested_at: DateTime.new(2023,7,25), harvest: 87, field: field)

puts "Farm created"

