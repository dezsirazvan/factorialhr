require 'rails_helper'

RSpec.describe Api::V1::ContactsController, type: :request do
  let(:json_response) { JSON.parse(response.body) }
  let!(:contact1) { create(:contact) }
  let!(:contact2) { create(:contact) }
  let(:headers) do
    {
      'Content-Type' => 'application/json'
    }
  end
  let(:contact_params) do {
      contact: { 
        first_name: 'Test', 
        last_name: 'Test Last Name',
        email: 'test@test.com',
        phone_number: '+34567789123'
      }
    }
  end

  describe 'GET /api/v1/contacts/:id' do
    context "get the contact by id" do
      it 'returns status code 200', :show_in_doc do
        get "/api/v1/contacts/#{contact1.id}", {}

        expect(response).to have_http_status(:ok)
      end
      
      it 'returns the contact not found error', :show_in_doc do
        get "/api/v1/contacts/test", {}

        expect(response).to have_http_status(:not_found)
      end

      it 'returns the correct contact', :show_in_doc do
        get "/api/v1/contacts/#{contact1.id}", {}

        expect(json_response["id"]).to eq(contact1.id)
      end
    end
  end

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

  describe 'POST /api/v1/contacts/' do
    context "create a new contact" do
      it 'returns status code 200', :show_in_doc do
        post "/api/v1/contacts", params: contact_params.to_json, headers: headers

        expect(response).to have_http_status(:ok)
      end

      it 'returns status code 422', :show_in_doc do
        post "/api/v1/contacts", params: { contact: { first_name: 'test' } }.to_json, headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
      end
  
      it 'returns the created contact', :show_in_doc do
        post "/api/v1/contacts", params: contact_params.to_json, headers: headers

        expect(json_response["first_name"]).to eq(contact_params[:contact][:first_name])
        expect(json_response["last_name"]).to eq(contact_params[:contact][:last_name])
        expect(json_response["email"]).to eq(contact_params[:contact][:email])
      end
    end
  end

  describe 'PUT /api/v1/contacts/:id' do
    context "update a contact" do
      it 'returns status code 200', :show_in_doc do
        put "/api/v1/contacts/#{contact1.id}", params: { contact: { first_name: "Updated" } }.to_json, headers: headers

        expect(response).to have_http_status(:ok)
      end

      it 'returns status code 401', :show_in_doc do
        put "/api/v1/contacts/test", params: { contact: { first_name: 'test' } }.to_json, headers: headers

        expect(response).to have_http_status(:not_found)
      end
  
      it 'returns the created contact', :show_in_doc do
        put "/api/v1/contacts/#{contact1.id}", params: { contact: { first_name: "Updated" } }.to_json, headers: headers

        expect(json_response["first_name"]).to eq('Updated')
      end
    end
  end

  describe 'DELETE /api/v1/contacts/:id' do
    context "delete a contact" do
      it 'returns status code 200', :show_in_doc do
        delete "/api/v1/contacts/#{contact1.id}", {}

        expect(response).to have_http_status(:ok)
      end

      it 'returns status code 401', :show_in_doc do
        delete "/api/v1/contacts/test"

        expect(response).to have_http_status(:not_found)
      end
  
      it 'deletes the contact correctly', :show_in_doc do
        delete "/api/v1/contacts/#{contact1.id}", {}

        expect(Contact.count).to eq(1)
      end
    end
  end

  describe 'GET /api/v1/contacts/:id/versions' do
    context "get the versions for a specific contact" do
      it 'returns status code 200', :show_in_doc do
        get "/api/v1/contacts/#{contact1.id}/versions", {}

        expect(response).to have_http_status(:ok)
      end
      
      it 'returns the contact not found error', :show_in_doc do
        get "/api/v1/contacts/test/versions", {}

        expect(response).to have_http_status(:not_found)
      end

      it 'returns the correct versions', :show_in_doc do
        contact1.update(first_name: "Test Updated")

        get "/api/v1/contacts/#{contact1.id}/versions", {}

        expect(json_response["data"].count).to eq(2)
        expect(json_response["data"].last["first_name"][1]).to eq ("Test Updated")
      end
    end
  end
end
