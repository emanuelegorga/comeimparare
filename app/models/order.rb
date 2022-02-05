# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user

  monetize :total, as: 'total_amount', with_currency: :eur
end