# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#load seed admin user
Admin.delete_all

@admin = Admin.new
@admin.email = "admin@advisorfeed.com"
@admin.password = "advisor@123"
@admin.password_confirmation = "advisor@123"
@admin.save
