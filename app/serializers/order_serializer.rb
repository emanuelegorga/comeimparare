# frozen_string_literal: true

class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total, :purchased, :payment_method, :created_at, :metadata, :paid_at

  belongs_to :user
  
  def purchased
    Course.where(id: object.courses).map do |course|
      {
        course: course,
        logo_url: course.logo_url
      }
    end
  end
end
