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

# 遍历 JSON 数据并创建记录
questions_data['questions'].each do |question_data|
  question = Question.find_or_create_by(content: question_data['content']) do |q|
    q.code = question_data['code']
    q.correct_answer = question_data['correct_answer']
    q.explanation = question_data['explanation']
  end

  question_data['options'].each do |option_data|
    question.options.find_or_create_by(label: option_data['label']) do |o|
      o.content = option_data['content']
    end
  end
end

puts "Seed data has been successfully loaded into the database."