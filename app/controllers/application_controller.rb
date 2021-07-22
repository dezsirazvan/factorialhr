# frozen_string_literal: true

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_unprocessable_response(exception)
    message = {
      error: 'Unprocessable entity',
      message: exception.record.errors
    }

    render json: message, status: :unprocessable_entity
  end

  def render_not_found_response(exception)
    message = {
      error: 'Record not found',
      message: exception.message
    }

    render json: message, status: :not_found
  end
end
