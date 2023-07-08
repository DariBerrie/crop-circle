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

# create different tasks
puts "Creating tasks"
tasks = [
  {
    fieldOperationsType: "tillage",
    startDate: "2023-07-02",
    endDate: "2023-07-02",
    workStatus: "done",
    farm: Farm.first
  },
  {
    fieldOperationsType: "seeding",
    startDate: "2023-07-09",
    endDate: "2023-07-09",
    workStatus: "planned",
    farm: Farm.first
  },
  {
    fieldOperationsType: "harvest",
    startDate: "2023-08-16",
    endDate: "2023-08-16",
    workStatus: "planned",
    farm: Farm.first
  }
]

tasks.each do |task|
  Task.create!(task)
end
puts "Tasks created"