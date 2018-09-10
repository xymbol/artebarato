# frozen_string_literal: true

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start 'rails'
end

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'webmock/minitest'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Asserts that two arrays have the same elements disregarding the ordering
  # between the actual and expected array.
  def assert_match_array(expected, actual, message = nil)
    assert_equal expected.sort, actual.sort, message
  end
end
