# frozen_string_literal: true

class ApplicationController < ActionController::API
  include TokenAuthenticatable
  rescue_from ActionController::ParameterMissing, with: :param_missing
  CONTENT_TYPE = 'application/json'

  private

  def param_missing(error)
    render_error(status: 400,
                 title: 'Parameter Missing',
                 message: error.message)
  end

  def render_error(status:, title:, message:)
    render json: { errors: [{ status: status.to_s,
                              title: title,
                              detail: message }] },
           status: status, content_type: CONTENT_TYPE
  end
end
