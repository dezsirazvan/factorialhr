require 'rails_helper'

RSpec.describe AverageValuesCalculatorService do
  let(:values) { [1,2,3] }
  subject(:service) { described_class.new(values) }

  context "#initialize" do
    it "sets the values array correctly" do
      expect(service.values_array).to eq values
    end
  end

  context "#calculate" do
    let(:result) { service.calculate }

    it "calculates the average correctly for the values array" do
      expect(result).to eq 2
    end
  end
end
