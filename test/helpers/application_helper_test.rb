# frozen_string_literal: true

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'returns navigable categories' do
    assert_equal \
      [categories(:musica), categories(:muestra)], navigable_categories
  end
end
