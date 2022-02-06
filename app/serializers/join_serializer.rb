# frozen_string_literal: true

class JoinSerializer < ActiveModel::Serializer
  attributes :id, :rating, :review, :price, :created_at, :updated_at, :username, :user_id

  belongs_to :course
  belongs_to :user

  def username
    object.user.name
  end

  def user_id
    object.user.id
  end
end
