# frozen_string_literal: true

class TimelineCalculatorService
  attr_reader :metrics_grouped

  def initialize(metrics_grouped)
    @metrics_grouped = metrics_grouped
  end

  def calculate
    final_result = []

    @metrics_grouped.each do |key, value|
      values = values_array(value)
      average = average_value(values)

      final_result << result_object(key, average, value)
    end

    final_result
  rescue StandardError => error
    Rails.logger(error)
    []
  end

  private

    def average_value(values)
      values.inject { |sum, el| sum + el }.to_f / values.size
    rescue StandarError => error
      Rails.logger(error)
      nil
    end

    def result_object(key, average, value)
      {
        date: key,
        average: average,
        metrics: value
      }
    end

    def values_array(value)
      value.pluck(:value)
    end
end
