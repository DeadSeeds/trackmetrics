# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
require 'faker'

10.times do
  User.create!(
    email:      Faker::Internet.safe_email,
    password:   "password",
    role:       'member'
  )
end
users = User.all

20.times do
  RegisteredApplication.create!(
    name:     Faker::Hipster.sentence(1),
    url:      Faker::Internet.domain_name,
    user:     User.all.sample
  )
end
apps = RegisteredApplication.all

50.times do
  Event.create!(
    name:                         Faker::Hipster.words(3).join,
    registered_application:       RegisteredApplication.all.sample
  )
end


user = User.first
user.update_attributes!(
  email:    'callitaclue@yahoo.com',
  password: 'password21',
  role:     'admin'
)


puts "Seed complete"
puts "#{RegisteredApplication.count} apps created"
puts "#{User.count} users created"
puts "#{Event.count} events created"
