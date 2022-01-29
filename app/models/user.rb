# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, :name, :password_digest, :platform, presence: true
  validates :email, uniqueness: true

  has_many :courses
end