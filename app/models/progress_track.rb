
# frozen_string_literal: true

class ProgressTrack < ApplicationRecord
  belongs_to :user
  belongs_to :lecture

  validates :user, :lecture, presence: true

  validates_uniqueness_of :user_id, scope: :lecture_id
  validates_uniqueness_of :lecture_id, scope: :user_id
end

