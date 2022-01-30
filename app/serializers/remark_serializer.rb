class RemarkSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :lecture_id, :created_at, :updated_at

  belongs_to :user
  belongs_to :lecture
end
