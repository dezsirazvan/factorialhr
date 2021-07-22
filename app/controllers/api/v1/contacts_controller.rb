# frozen_string_literal: true

class Api::V1::ContactsController < ApplicationController
  include Api::V1::ContactsControllerDoc

  before_action :find_contact, except: [:index, :create]

  def index
    @contacts = Contact.all

    render json: @contacts, each_serializer: Contact::ObjectSerializer, status: :ok
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.save!

    render json: @contact, serializer: Contact::ObjectSerializer, status: :created
  end

  def show
    render json: @contact, serializer: Contact::ObjectSerializer, status: :ok
  end

  def update
    @contact.update!(contact_params)

    render json: @contact, serializer: Contact::ObjectSerializer, status: :ok
  end

  def destroy
    @contact.destroy!

    render json: { message: 'Contact was successfully deleted.' }, status: :ok
  end

  def versions
    versions = @contact.versions.map(&:changeset)

    render json: { data: versions, message: 'Success' }, status: :ok
  end

  private

    def contact_params
      params.require(:contact).permit(:id, :first_name, :last_name, :email, :phone_number)
    end

    def find_contact
      @contact = Contact.find(params[:id])
    end
end
