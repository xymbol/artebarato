# frozen_string_literal: true

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'returns navigable categories' do
    assert_equal \
      [categories(:muestra), categories(:musica)], navigable_categories
  end
end
