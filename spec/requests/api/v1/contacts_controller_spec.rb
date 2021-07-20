require 'rails_helper'

RSpec.describe Api::V1::ContactsController, type: :request do
  let(:json_response) { JSON.parse(response.body) }
  let!(:contact1) { create(:contact) }
  let!(:contact2) { create(:contact) }

  describe 'GET /api/v1/contacts/' do
    context "get the list of contacts" do
      it 'returns status code 200', :show_in_doc do
        get "/api/v1/contacts", {}

        expect(response).to have_http_status(:ok)
      end
  
      it 'returns the correct number of contacts', :show_in_doc do
        get "/api/v1/contacts", {}
        
        expect(json_response.count).to eq(2)
      end
    end
  end
end
