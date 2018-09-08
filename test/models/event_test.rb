# frozen_string_literal: true

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test 'fixtures are valid' do
    %i[bergman cachitasnow].each do |name|
      assert events(name).valid?
    end
  end
end
