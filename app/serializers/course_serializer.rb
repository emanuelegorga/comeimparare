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
    :rejected,
    :publish,
    :unpublish

  belongs_to :user
  has_many :lectures
  has_many :joins
  has_many :progress_tracks
end
