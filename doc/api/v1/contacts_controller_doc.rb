module Api::V1::ContactsControllerDoc
  extend Apipie::DSL::Concern

  api :GET, '/contacts', 'Get all contacts'
  def index
  end

  api :GET, '/contacts/:id', 'Get contact by id'
  param 'id', Integer, required: true
  def show
  end

  api :POST, '/contacts/', 'Create a new contact'
  param :contact, Hash, required: true do
    param :first_name, String, required: true
    param :last_name, String, required: true
    param :email, String, required: true
    param :phone_number, String, required: true
  end
  def create
  end

  api :PUT, '/contacts/:id', 'Update a contact'
  param 'id', Integer, required: true
  param :contact, Hash, required: true do
    param :first_name, String, required: true
    param :last_name, String, required: true
    param :email, String, required: true
    param :phone_number, String, required: true
  end
  def update
  end

  api :DELETE, '/contacts/:id', 'Delete a contact'
  param 'id', Integer, required: true
  def destroy
  end

  api :GET, '/contacts/:id/versions', 'Get contact versions (updates history)'
  param 'id', Integer, required: true
  def versions
  end
end
