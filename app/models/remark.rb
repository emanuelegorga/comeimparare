# frozen_string_literal: true

class Remark < ApplicationRecord
  belongs_to :user
  belongs_to :lecture

  validates :content, presence: true
end
