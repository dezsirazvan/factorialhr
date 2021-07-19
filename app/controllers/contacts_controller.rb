# frozen_string_literal: true

class ContactsController < ApplicationController
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
    @contact = Contact.find(params[:id])
    render json: { data: @contact, status: :ok, message: 'Success' }
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      render json: { status: :ok, message: 'Success' }
    else
      render json: { json: @contact.error, status: :unprocessable_entity }
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    if @contact.destroy
      render json: { json: 'Contact was successfully deleted.' }
    else
      render json: { json: @contact.errors, status: :unprocessable_entity }
    end
  end

  private

    def contact_params
      params.require(:contact).permit(:id, :first_name, :last_name, :email, :phone_number)
    end
end
