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
  has_many :lectures, dependent: :destroy, inverse_of: :course
  has_many :joins
  has_many :progress_tracks, through: :lectures

  scope :from_different_teachers, -> (current_user) { where.not(user: current_user) }
  scope :latest, -> { order(created_at: :desc) }
  scope :top_rated, -> { order(average_rating: :desc, created_at: :desc) }
  scope :most_popular, -> { joins(:joins).group('joins.id').order('COUNT(joins.id)') }
  scope :purchased, -> (current_user) do
    joins(:joins)
      .where(
        joins: { user: current_user }
      ).order(created_at: :desc)
  end
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  scope :accepted, -> { where(accepted: true) }
  scope :rejected, -> { where(accepted: false) }
  scope :pending, -> { where(accepted: nil) }

  def already_joined?(user)
    self.joins.where(user_id: user.id, course_id: id).empty?
  end

  def rate!
    if joins.any? && joins.where.not(rating: nil).any?
      update_column(:average_rating, joins.average(:rating).round(2).to_f)
    else
      update_column(:average_rating, 0)
    end
  end

  def progress(user)
    unless self.lectures.count == 0
      progress_tracks.where(user: user).count.to_f / self.lectures.count.to_f * 100
    end
  end

  def rejected?
    !accepted
  end
end
