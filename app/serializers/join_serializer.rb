class JoinSerializer < ActiveModel::Serializer
  attributes :id, :rating, :review, :price, :created_at, :updated_at

  belongs_to :course
  belongs_to :user
end
