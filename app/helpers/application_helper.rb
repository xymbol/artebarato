# frozen_string_literal: true

module ApplicationHelper
  def navigable_categories
    @navigable_categories ||= Category.ordered
  end
end
