# frozen_string_literal: true

class NotAuthorizedError < StandardError; end

module TokenAuthenticatable
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user

    before_action :authenticate_user

    rescue_from NotAuthorizedError, with: :unauthorized_error
  end

  private

  def authenticate_user
    @current_user = DecodeAuthenticationCommand.call(request.headers).result
    raise NotAuthorizedError unless @current_user
  end

  def unauthorized_error
    render_error(status: 401,
                 title: 'Not Authorized',
                 message: 'You are not authorized to access this resource')
  end
end
