# frozen_string_literal: true

class ContactsController < ApplicationController
  before_action :find_contact, except: [:index, :create]

  def index
    @contacts = Contact.all

    render json: @contacts, each_serializer: Contact::ListSerializer
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact, serializer: Contact::ObjectSerializer
    else
      render json: { errors: @contact.errors }, status: :unprocessable_entity
    end
  end

  def show
    render json: @contact, serializer: Contact::ObjectSerializer
  end

  def update
    if @contact.update(contact_params)
      render json: @contact, serializer: Contact::ObjectSerializer
    else
      render json: { errors: @contact.error, status: :unprocessable_entity }
    end
  end

  def destroy
    if @contact.destroy
      render json: { message: 'Contact was successfully deleted.' }
    else
      render json: { errors: @contact.errors, status: :unprocessable_entity }
    end
  end

  def versions
    versions = @contact.versions.map(&:changeset)

    render json: { data: versions, status: :ok, message: 'Success' }
  end

  private

    def contact_params
      params.require(:contact).permit(:id, :first_name, :last_name, :email, :phone_number)
    end

    def find_contact
      @contact = Contact.find(params[:id])
    end
end
