# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'json'

# 读取 JSON 文件
json_file_path = Rails.root.join('db/seeds/questions.json')
questions_data = JSON.parse(File.read(json_file_path))

puts "Total questions in JSON: #{questions_data['questions'].count}"

# 遍历 JSON 数据并创建记录
Question.destroy_all
Option.destroy_all

questions_data['questions'].each_with_index do |question_data, index|
  question = Question.create!(
    content: question_data['content'],
    code: question_data['code'],
    correct_answer: question_data['correct_answer'],
    explanation: question_data['explanation']
  )

  question_data['options'].each do |option_data|
    question.options.create!(
      label: option_data['label'],
      content: option_data['content']
    )
  end

  puts "Processed question #{index + 1}"
end

puts "Total questions in database: #{Question.count}"
puts "Total questions imported: #{Question.count}"