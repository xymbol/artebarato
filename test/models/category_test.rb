# frozen_string_literal: true

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'fixtures are valid' do
    %i[muestra musica].each do |name|
      assert categories(name).valid?
    end
  end

  test 'sets slug on create' do
    category = Category.create name: 'Teatro'
    assert_equal 'teatro', category.slug
  end
end
