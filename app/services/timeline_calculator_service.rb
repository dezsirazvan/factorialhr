# frozen_string_literal: true

class TimelineCalculatorService
  DEFAULT_AVERAGE_TYPE = 'day'

  def calculate(metrics, average_type)
    final_result = []

    metrics = metrics_grouped(metrics, average_type)

    metrics.each do |key, value|
      values = values_array(value)
      average = average_value(values)

      final_result << result_object(key, average, value)
    end

    final_result
  rescue NoMethodError
    []
  end

  private

    def result_object(key, average, value)
      {
        date: key,
        average: average,
        metrics: value
      }
    end

    def metrics_grouped(metrics, average_type)
      average_type = average_type.nil? ? DEFAULT_AVERAGE_TYPE : average_type

      metrics.group_by_average_type(average_type.to_sym)
    end

    def values_array(value)
      value.pluck(:value)
    end

    def average_value(values)
      values.inject { |sum, el| sum + el }.to_f / values.size
    rescue NoMethodError
      nil
    end
end
