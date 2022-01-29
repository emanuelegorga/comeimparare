class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :platform, :name, :created_at, :updated_at, :avatar_url

  has_many :courses
end
