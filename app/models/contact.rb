# frozen_string_literal: true

class Contact < ApplicationRecord
  has_paper_trail

  validates :phone_number, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
end
