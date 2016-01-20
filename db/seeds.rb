# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.new(first_name: "Bob", last_name: "Example", email: "bob@example.com", password: "bob eats cheese")
unless User.find_by_email "bob.example.com"
  user.save!
  puts "User #{user.full_name} successfully created."
else
  puts "User with email #{user.email} already exists."
end

unless Account.find_by_subdomain "example"
  account = Account.create!(name: "Example", subdomain: "example", user: user)
  puts "#{account.name} account successfully created."
else
  puts "#{account.name} account already exists."
end

exam = Exam.new(account: account, name: "Sample Test", description: "This is a sample test. " * 20)
existing_exam = Exam.where(account: account, name: exam.name).first
if existing_exam
  existing_exam.update!(exam.attributes.reject { |k, v| v.blank? } )
  puts "Updated #{exam.name}."
else
  exam.save!
  puts "Created #{exam.name}."
end
