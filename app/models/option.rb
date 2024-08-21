class Option < ApplicationRecord
  belongs_to :question
  validates :content, presence: true
  validates :label, presence: true
end