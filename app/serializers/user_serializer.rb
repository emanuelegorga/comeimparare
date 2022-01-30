# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :platform, :name, :created_at, :updated_at, :avatar_url, :balance

  has_many :courses
  has_many :joins
  has_many :progress_tracks
  has_many :remarks
end
