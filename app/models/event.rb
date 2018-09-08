# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :category

  scope :ordered, -> { order tweet_id: :desc }

  validates :tweet_id, uniqueness: true
end
