# frozen_string_literal: true

class Metric < ApplicationRecord
  validates :name, presence: true
  validates :value, presence: true, numericality: { only_integer: true }

  scope :group_by_average_type, ->(average_type) { group_by_period(average_type, &:created_at) }
end
