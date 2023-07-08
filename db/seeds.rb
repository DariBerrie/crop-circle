# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Destroying user and farms"

Farm.destroy_all
User.destroy_all

user = User.create!(first_name: "Jeanne", last_name: "Farmer", email: "jeanne.farmer@example.com",
             username: "j_farmer", password: "123456")

puts "Jeanne Farmer created"
Farm.create!(address: "400 Chemin Des Pins, 26260 Saint Donat Sur L'Herbasse, France", user: user)

puts "Farm created"

