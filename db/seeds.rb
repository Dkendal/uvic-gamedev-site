# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cms::Site.create! identifier: 'gamedev', label: 'gamedev', hostname: 'localhost:3000'
user = User.create! email: 'test@example.com', password: 'test12345'
user.add_role :admin
