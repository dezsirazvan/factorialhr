# frozen_string_literal: true

class Metric < ApplicationRecord
  validates :name, presence: true
  validates :value, presence: true

  scope :averages_per_minut, -> { where("created_at >= ? AND created_at <= ?", DateTime.current.beginning_of_minut, DateTime.current.end_of_minut) }
  scope :averages_per_hour, -> { where("created_at >= ? AND created_at <= ?", DateTime.current.beginning_of_hour, DateTime.current.end_of_hour) }
  scope :averages_per_day, -> { where("created_at >= ? AND created_at <= ?", DateTime.current.beginning_of_day, DateTime.current.end_of_day) }
end
