class LectureSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :updated_at

  belongs_to :course
  has_many :progress_tracks
end
