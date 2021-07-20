require 'rails_helper'

RSpec.describe GroupMetricsService do
  let(:metric1) { create(:metric) }
  let(:metric2) { create(:metric) }
  let(:metrics) { [metric1, metric2] }
  let(:average_type) { "minute" }

  subject(:service) { described_class.new(metrics, average_type) }

  context "#initialize" do
    it "sets the metrics correctly" do
      expect(service.metrics).to eq metrics
    end

    it "sets the average_type correctly" do
      expect(service.average_type).to eq service.average_type
    end
  end

  context "#grouped" do
    context "when average type is minute" do
      let(:result) { service.group }

      it "calculates the metrics correctly by average type minute" do
        expect(result.first[0].strftime('%M')).to eq metric1.created_at.strftime('%M')
      end

      it "return the correct number of metrics for that minute" do
        expect(result.first[1]).to eq metrics
      end
    end

    context "when average type is second" do
      let(:subect_second) { described_class.new(metrics, 'second') }
      let(:result) { subect_second.group }

      it "calculates the metrics correctly by average type minute" do
        expect(result.first[0].strftime('%S')).to eq metric1.created_at.strftime('%S')
      end
    end

    context "when average type is day" do
      let(:subect_second) { described_class.new(metrics, 'day') }
      let(:result) { subect_second.group }

      it "calculates the metrics correctly by average type day" do
        expect(result.first[0].strftime('%d')).to eq metric1.created_at.strftime('%d')
      end
    end
  end
end
