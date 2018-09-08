# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    http_basic_authenticate_with auth_options if auth_enabled?
  end

  class_methods do
    def auth_enabled?
      ENV['AUTH_NAME'] && ENV['AUTH_PASSWORD']
    end

    def auth_options
      {
        name: ENV['AUTH_NAME'],
        password: ENV['AUTH_PASSWORD']
      }
    end
  end
end
