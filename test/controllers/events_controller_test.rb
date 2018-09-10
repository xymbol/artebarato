# frozen_string_literal: true

require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test 'index' do
    get root_url, auth_headers
    assert_response :success
  end

  test 'index without auth' do
    get root_url
    assert_response :unauthorized
  end

  test 'index with category' do
    get category_events_url(categories(:musica)), auth_headers
    assert_response :success
  end

  def auth_credentials
    ActionController::HttpAuthentication::Basic.encode_credentials \
      'admin', 'secret'
  end

  def auth_headers
    {
      headers: {
        Authorization: auth_credentials
      }
    }
  end
end
