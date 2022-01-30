# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, :name, :password_digest, :platform, presence: true

  has_many :courses, dependent: :nullify
  has_many :joins, dependent: :nullify
  has_many :progress_tracks, dependent: :nullify
  has_many :remarks, dependent: :nullify

  def join_course(course)
    self.joins.create!(course: course, price: course.price)
  end

  def view_lecture(lecture)
    if progress_track = self.progress_tracks.find_by(lecture: lecture)
      progress_track.increment!(:views)
    else
      self.progress_tracks.create(lecture: lecture)
    end
  end
end
