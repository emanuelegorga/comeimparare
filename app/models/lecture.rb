# frozen_string_literal: true

class Lecture < ApplicationRecord
  belongs_to :course

  validates :title, :content, :course, presence: true
  validates :title, length: { maximum: 80 }
  validates_uniqueness_of :title, scope: :course_id

  has_many :progress_tracks, dependent: :destroy
end