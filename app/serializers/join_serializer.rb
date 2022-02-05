# frozen_string_literal: true

class JoinSerializer < ActiveModel::Serializer
  attributes :id, :rating, :review, :price, :created_at, :updated_at, :username

  belongs_to :course
  belongs_to :user

  def username
    object.user.name
  end
end
