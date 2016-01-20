# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.new(first_name: "Bob", last_name: "Example", email: "bob@example.com", password: "bob eats cheese")
existing_user = User.find_by_email "bob@example.com"
unless existing_user
  user.save!
  puts "User #{user.full_name} successfully created."
else
  user = existing_user
  puts "User with email #{user.email} already exists."
end

account = Account.new(name: "Example", subdomain: "example", user: user)
existing_account = Account.find_by_subdomain "example"
unless existing_account
  account.save!
  puts "#{account.name} account successfully created."
else
  account = existing_account
  puts "#{account.name} account already exists."
end

exam = Exam.new(account: account, name: "Sample Test", description: "This is a sample test. " * 20, exam_type: "multiple_choice")
existing_exam = Exam.where(account: account, name: exam.name).first
if existing_exam
  existing_exam.update_attributes(exam.attributes.reject { |k, v| v.blank? } )
  exam = existing_exam
  puts "Updated #{exam.name}."
else
  exam.save!
  puts "Created #{exam.name}."
end

question_1 = Question.new(text: "What is your favorite number?", question_type: "multiple_choice", exam: exam)
existing_question_1 = Question.where(exam: exam, text: question_1.text).first
unless existing_question_1
  question_1.save!
  puts "Saving question_1."
else
  question_1 = existing_question
  puts "Question already exists."
end

answer_1_q1 = Answer.new(text: "Zero", value: 0, question: question_1)
existing_answer_1_q1 = Answer.where(value: answer_1_q1.value, question: question_1).first
unless existing_answer_1_q1
  answer_1_q1.save!
  puts "Saving first answer to first question."
else
  answer_1_q1 = existing_answer_1_q1
  puts "Answer already exists."
end

answer_2_q1 = Answer.new(text: "One", value: 1, question: question_1)
existing_answer_2_q1 = Answer.where(value: answer_2_q1.value, question: question_1).first
unless existing_answer_2_q1
  answer_2_q1.save!
  puts "Saving second answer to first question."
else
  answer_2_q1 = existing_answer_2_q1
  puts "Answer already exists."
end

answer_3_q1 = Answer.new(text: "Two", value: 2, question: question_1)
existing_answer_3_q1 = Answer.where(value: answer_3_q1.value, question: question_1).first
unless existing_answer_3_q1
  answer_3_q1.save!
  puts "Saving third answer to first question."
else
  answer_3_q1 = existing_answer_3_q1
  puts "Answer already exists."
end

question_2 = Question.new(text: "What is your next favorite number?", question_type: "multiple_choice", exam: exam)
existing_question_2 = Question.where(exam: exam, text: question_2.text).first
unless existing_question_2
  question_2.save!
  puts "Saving question_2."
else
  question_2 = existing_question
  puts "Question already exists."
end

answer_1_q2 = Answer.new(text: "Three", value: 3, question: question_1)
existing_answer_1_q2 = Answer.where(value: answer_1_q2.value, question: question_1).first
unless existing_answer_1_q2
  answer_1_q2.save!
  puts "Saving first answer to first question."
else
  answer_1_q2 = existing_answer_1_q2
  puts "Answer already exists."
end

answer_2_q2 = Answer.new(text: "Four", value: 4, question: question_1)
existing_answer_2_q2 = Answer.where(value: answer_2_q2.value, question: question_1).first
unless existing_answer_2_q2
  answer_2_q2.save!
  puts "Saving second answer to first question."
else
  answer_2_q2 = existing_answer_2_q2
  puts "Answer already exists."
end

answer_3_q2 = Answer.new(text: "Five", value: 5, question: question_1)
existing_answer_3_q2 = Answer.where(value: answer_3_q2.value, question: question_1).first
unless existing_answer_3_q2
  answer_3_q2.save!
  puts "Saving third answer to first question."
else
  answer_3_q2 = existing_answer_3_q2
  puts "Answer already exists."
end


