# frozen_string_literal: true

class Lecture < ApplicationRecord
  belongs_to :course

  validates :title, :content, :course, presence: true
end