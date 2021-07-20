# frozen_string_literal: true

class TimelineCalculatorService
  def initialize(metrics_grouped)
    @metrics_grouped = metrics_grouped
  end

  def calculate
    final_result = []

    return unless @metrics_grouped

    @metrics_grouped.each do |key, value|
      values = values_array(value)
      average = AverageValuesCalculatorService.new(values).calculate

      final_result << result_object(key, average, value)
    end

    final_result
  rescue StandardError => error
    Rails.logger(error)
    []
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
