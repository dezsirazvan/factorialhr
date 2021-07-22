require 'rails_helper'

RSpec.describe TimelineCalculatorService do
  let!(:metric1) { create(:metric) }
  let!(:metric2) { create(:metric) }
  let(:metrics) { [metric1, metric2] }
  let(:average_type) { 'day' }


  subject(:service) { described_class.new }

  context "#calculate" do
    let(:result) { service.calculate(Metric.all, average_type) }

    it "returns the average correctly" do
      expect(result.first[:average]).to eq Metric.all.average(:value).to_f
    end

    it "returns the metrics correctly" do
      expect(result.first[:metrics]).to eq metrics
    end

    it "returns the date correctly" do
      expect(result.first[:date]).to eq metric1.created_at.to_date
    end
  end
end
