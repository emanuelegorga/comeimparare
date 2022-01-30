# frozen_string_literal: true

class Lecture < ApplicationRecord
  VIDEO_ERROR_MESSAGE = 'Sorry, the size of this video is over than the limit allowed. Please use a video of size up to 50mb.'
  VIDEO_THUMBNAIL_ERROR_MESSAGE = 'Sorry, the size of this video thumbnail is over than the limit allowed. Please use a video thumbanail of size up to 500kb.'

  belongs_to :course

  validates :title, :content, :course, presence: true
  validates :title, length: { maximum: 80 }
  validates_uniqueness_of :title, scope: :course_id

  has_many :progress_tracks, dependent: :destroy
  has_many :remarks, dependent: :nullify

  has_one_attached :video
  has_one_attached :video_thumbnail

  validates :video,
    content_type: ['video/mp4'],
    size: { less_than: 50.megabytes, message: VIDEO_ERROR_MESSAGE }

  validates :video_thumbnail,
    content_type: ['image/png', 'image/jpg', 'image/jpeg'],
    size: { less_than: 500.kilobytes, message: VIDEO_THUMBNAIL_ERROR_MESSAGE }
end