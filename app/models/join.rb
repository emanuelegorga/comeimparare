# frozen_string_literal: true

class Join < ApplicationRecord
  belongs_to :course, counter_cache: true
  belongs_to :user, counter_cache: true
  
  validates_uniqueness_of :user_id, scope: :course_id
  validates_uniqueness_of :course_id, scope: :user_id
  validates_presence_of :review, if: :rating?
  validates_presence_of :rating, if: :review?
  validates :user, :course, presence: true
  validate :cannot_join_own_course

  scope :pending_review, -> { where(rating: [0, nil, ''], review: [0, nil, '']) }
  scope :reviewed, -> { where.not(review: [0, nil, ""]) }
  scope :latest_top_reviewed, -> { reviewed.order(rating: :desc, created_at: :desc) }

  after_save do
    course.rate! unless rating.nil? || rating.zero?
  end

  after_destroy { course.rate! }

  after_create :calculate_balance
  after_destroy :calculate_balance

  def calculate_balance
    course.calculate_profit
    user.calculate_join_costs
  end

  protected

  def cannot_join_own_course
    if self.new_record? && self.user_id.present?
      if user_id == course.user_id
        errors.add(:base, 'You cannot join to your own course.')
      end
    end
  end
end
