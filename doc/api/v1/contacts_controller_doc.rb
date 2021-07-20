module Api::V1::ContactsControllerDoc
  extend Apipie::DSL::Concern

  api :GET, '/contacts', 'Get all contacts'
  def index
  end

  api :GET, '/contacts/:id', 'Get contact by id'
  def show
  end
end
