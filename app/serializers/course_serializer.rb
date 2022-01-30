# frozen_string_literal: true

class CourseSerializer < ActiveModel::Serializer
  attributes :id, 
    :title,
    :metadata,
    :description,
    :summary,
    :difficulty,
    :language,
    :price,
    :created_at,
    :updated_at,
    :accepted,
    :published,
    :average_rating,
    :profit

  belongs_to :user
  has_many :lectures
  has_many :joins
  has_many :progress_tracks
end
