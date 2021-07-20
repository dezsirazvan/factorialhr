require 'rails_helper'

RSpec.describe TimelineCalculatorService do
  let(:metric1) { create(:metric) }
  let(:metric2) { create(:metric) }
  let(:metrics) { [metric1, metric2] }
  let(:metrics_grouped) { 
    { 
      metric1.created_at.to_date => metrics
    }
  }

  subject(:service) { described_class.new(metrics_grouped) }

  context "#initialize" do
    it "sets the metrics grouped correctly" do
      expect(service.metrics_grouped).to eq metrics_grouped
    end
  end

  context "#calculate" do
    let(:result) { service.calculate }

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
