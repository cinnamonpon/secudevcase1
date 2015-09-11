# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(fname: "Admin", lname: "Admin", password: "pusajo69", username: "admin", gender: "Male", salutation: "Mr", birthdate: "06-06-1990", about: "About me", role: "admin")
