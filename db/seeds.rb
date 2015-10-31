# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(fname: "Admin", lname: "Admin", password: "pusajo69", username: "admin", gender: "Male", salutation: "Mr", birthdate: "06-06-1990", about: "About me", role: "admin")

StoreItem.create(name: "$5 Donation", description: "Donate $5 to Pua Store", price: 5)
StoreItem.create(name: "$10 Donation", description: "Donate $10 to Pua Store", price: 10)
StoreItem.create(name: "$20 Donation", description: "Donate $20 to Pua Store", price: 20)
