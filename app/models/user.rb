# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  has_secure_password

  after_create :assign_default_roles

  validate :minimum_role_check, on: :update
  validates :email, :name, :password_digest, :platform, presence: true

  has_many :courses, dependent: :nullify
  has_many :joins, dependent: :nullify
  has_many :progress_tracks, dependent: :nullify
  has_many :remarks, dependent: :nullify
  has_many :orders, dependent: :nullify

  def assign_default_roles
    if User.count == 1
      self.add_role(:admin) if self.roles.blank?
      self.add_role(:teacher)
      self.add_role(:student)
    else
      self.add_role(:teacher) if self.roles.blank?
      self.add_role(:student)
    end
  end

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

  def calculate_course_profit
    update_column(:course_profit, (courses.map(&:profit).sum))
    update_column(:balance, (course_profit - join_costs))
  end

  def calculate_join_costs
    update_column(:join_costs, (joins.map(&:price).sum))
    update_column(:balance, (course_profit - join_costs))
  end

  def rate_course(course_to_rate, rate, review = nil)
    return false unless joins.where(course_id: course_to_rate.id)
    join = joins.where(course_id: course_to_rate)[0]
    join.update(rating: rate, review: review)
    course_to_rate.rate!
  end 

  private

  def minimum_role_check
    if roles.blank?
      errors.add(:roles, 'Each user is required to have at least one role.')
    end
  end
end
