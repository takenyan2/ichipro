class Question < ApplicationRecord
  validates :user_question, presence: true, length: { maximum: 100 }
  validates :answer, presence: true, length: { maximum: 200 }
end
