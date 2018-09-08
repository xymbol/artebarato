# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    @events = find_events.ordered
  end

  private

  def find_category
    Category.friendly.find params[:category_id] if params[:category_id]
  end

  def find_events
    (category = find_category) ? category.events : Event.all
  end
end
