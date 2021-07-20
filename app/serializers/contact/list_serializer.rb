# frozen_string_literal: true

class Contact::ListSerializer < ActiveModel::Serializer
  attributes :id,
             :first_name,
             :last_name,
             :email,
             :phone_number,
             :created_at
end
