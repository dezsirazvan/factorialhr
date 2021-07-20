# frozen_string_literal: true

class AverageValuesCalculatorService
  def initialize(values_array)
    @values_array = values_array
  end

  def calculate
    @values_array.inject { |sum, el| sum + el }.to_f / @values_array.size
  rescue StandarError => error
    Rails.logger(error)
    nil
  end
end
