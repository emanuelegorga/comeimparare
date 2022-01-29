class CourseSerializer < ActiveModel::Serializer
  attributes :id, :title, :metadata, :description, :difficulty, :language, :price, :created_at, :updated_at

  belongs_to :user
end
