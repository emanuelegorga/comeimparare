# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, :name, :password_digest, :platform, presence: true

  has_many :courses, dependent: :nullify
end
