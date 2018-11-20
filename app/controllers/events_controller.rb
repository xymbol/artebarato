# frozen_string_literal: true

class EventsController < ApplicationController
  MAX_EVENTS = 60

  def index
    @events = find_events.ordered.limit MAX_EVENTS
  end

  private

  def find_category
    Category.friendly.find params[:category_id] if params[:category_id]
  end

  def find_events
    (category = find_category) ? category.events : Event.all
  end
end
