# frozen_string_literal: true

require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test 'index' do
    get root_url
    assert_response :success
  end

  test 'index with category' do
    get category_events_url(categories(:musica))
    assert_response :success
  end
end
