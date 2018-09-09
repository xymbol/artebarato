# frozen_string_literal: true

module ApplicationHelper
  NAVIGABLE_NUMBER = 7

  def navigable_categories
    @navigable_categories ||= Category.navigable NAVIGABLE_NUMBER
  end
end
