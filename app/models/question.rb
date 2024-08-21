class Question < ApplicationRecord
  has_many :options, dependent: :destroy
  validates :content, presence: true
  validates :correct_answer, presence: true
  def correct_answers
    correct_answer.split(',') if correct_answer.present?
  end

  def correct_answers=(answers)
    self.correct_answer = answers.join(',') if answers.is_a?(Array)
  end
end