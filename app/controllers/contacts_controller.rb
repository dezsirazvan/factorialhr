# frozen_string_literal: true

class ContactsController < ApplicationController
  before_action :find_contact, except: [:index, :create]
  def index
    @contacts = Contact.all
    render json: @contacts
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: { status: :ok, message: 'Success' }
    else
      render json: { json: @contact.errors }, status: :unprocessable_entity
    end
  end

  def show
    render json: { data: @contact, status: :ok, message: 'Success' }
  end

  def update
    if @contact.update(contact_params)
      render json: { status: :ok, message: 'Success' }
    else
      render json: { json: @contact.error, status: :unprocessable_entity }
    end
  end

  def destroy
    if @contact.destroy
      render json: { json: 'Contact was successfully deleted.' }
    else
      render json: { json: @contact.errors, status: :unprocessable_entity }
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
