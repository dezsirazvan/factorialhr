# frozen_string_literal: true

class Metric < ApplicationRecord
  validates :name, presence: true
  validates :value, presence: true, numericality: { only_integer: true }

  scope :in_interval, ->(start_date, end_date) { where('created_at >= ? AND created_at <= ?', start_date.to_date.beginning_of_day, end_date.to_date.end_of_day) }
end
