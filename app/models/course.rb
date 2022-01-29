# frozen_string_literal: true

class Course < ApplicationRecord
  validates :title, :description, :summary, :difficulty, :language, :price, presence: true
  validates :description, length: { minumum: 10, maximum: 3500 }

  DIFFICULTY_LEVELS = {
    easy: 0,
    medium: 1,
    hard: 2
  }.freeze

  LANGUAGES = {
    english: 0,
    italian: 1,
    spanish: 2,
    french: 3
  }.freeze

  enum difficulty: DIFFICULTY_LEVELS
  enum language: LANGUAGES

  scope :recent, -> { order(created_at: :desc) }

  belongs_to :user
end
