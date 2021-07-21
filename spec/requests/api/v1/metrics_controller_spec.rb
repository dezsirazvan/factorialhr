require 'rails_helper'

RSpec.describe Api::V1::MetricsController, type: :request do
  let(:json_response) { JSON.parse(response.body) }
  let!(:metric1) { create(:metric) }
  let!(:metric2) { create(:metric, created_at: metric1.created_at + 2.second) }
  let(:headers) do
    {
      'Content-Type' => 'application/json'
    }
  end
  let(:metric_params) do {
      metric: { 
        name: 'Test', 
        value: 10
      }
    }
  end

  describe 'GET /api/v1/metrics/:id' do
    context "get the metric by id" do
      it 'returns status code 200', :show_in_doc do
        get "/api/v1/metrics/#{metric1.id}", {}

        expect(response).to have_http_status(:ok)
      end
      
      it 'returns the metric not found error', :show_in_doc do
        get "/api/v1/metrics/test", {}

        expect(response).to have_http_status(:not_found)
      end

      it 'returns the correct metric', :show_in_doc do
        get "/api/v1/metrics/#{metric1.id}", {}

        expect(json_response["id"]).to eq(metric1.id)
      end
    end
  end

  describe 'GET /api/v1/metrics/' do
    context "get the list of metrics" do
      it 'returns status code 200', :show_in_doc do
        get "/api/v1/metrics", {}

        expect(response).to have_http_status(:ok)
      end
  
      it 'returns the correct number of metrics', :show_in_doc do
        get "/api/v1/metrics", {}
        
        expect(json_response.count).to eq(2)
      end
    end
  end

  describe 'POST /api/v1/metrics/' do
    context "create a new metric" do
      it 'returns status code 200', :show_in_doc do
        post "/api/v1/metrics", params: metric_params.to_json, headers: headers

        expect(response).to have_http_status(:ok)
      end

      it 'returns status code 422', :show_in_doc do
        post "/api/v1/metrics", params: { metric: { first_name: 'test' } }.to_json, headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
      end
  
      it 'returns the created metric', :show_in_doc do
        post "/api/v1/metrics", params: metric_params.to_json, headers: headers

        expect(json_response["name"]).to eq(metric_params[:metric][:name])
        expect(json_response["value"]).to eq(metric_params[:metric][:value])
      end
    end
  end

  describe 'PUT /api/v1/metrics/:id' do
    context "update a metric" do
      it 'returns status code 200', :show_in_doc do
        put "/api/v1/metrics/#{metric1.id}", params: { metric: { name: "Updated" } }.to_json, headers: headers

        expect(response).to have_http_status(:ok)
      end

      it 'returns status code 401', :show_in_doc do
        put "/api/v1/metrics/test", params: { metric: { first_name: 'test' } }.to_json, headers: headers

        expect(response).to have_http_status(:not_found)
      end
  
      it 'returns the created metric', :show_in_doc do
        put "/api/v1/metrics/#{metric1.id}", params: { metric: { name: "Updated" } }.to_json, headers: headers

        expect(json_response["name"]).to eq('Updated')
      end
    end
  end

  describe 'DELETE /api/v1/metrics/:id' do
    context "delete a metric" do
      it 'returns status code 200', :show_in_doc do
        delete "/api/v1/metrics/#{metric1.id}", {}

        expect(response).to have_http_status(:ok)
      end

      it 'returns status code 401', :show_in_doc do
        delete "/api/v1/metrics/test"

        expect(response).to have_http_status(:not_found)
      end
  
      it 'deletes the metric correctly', :show_in_doc do
        delete "/api/v1/metrics/#{metric1.id}", {}

        expect(Metric.count).to eq(1)
      end
    end
  end

  describe 'GET /api/v1/metrics/timeline' do
    context "get the versions for a specific metric" do
      it 'returns status code 200', :show_in_doc do
        get "/api/v1/metrics/timeline?average_type=day", {}

        expect(response).to have_http_status(:ok)
      end
    
      it 'returns the correct version average value (average type default=day)', :show_in_doc do
        get "/api/v1/metrics/timeline", {}

        expect(json_response.count).to eq(1)
        expect(json_response.first["average"]).to eq(Metric.all.average(:value))
      end

      it 'returns the correct version average value for second average type', :show_in_doc do
        get "/api/v1/metrics/timeline?average_type=second"
        
        expect(json_response.count).to eq(2)
        expect(json_response.first["average"]).to eq(metric1.value)
      end
    end
  end
end
