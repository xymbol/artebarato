# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :category

  scope :ordered, -> { order tweet_created_at: :desc }

  validates :tweet_created_at, presence: true
  validates :tweet_id, uniqueness: true
  validates :tweet_text, presence: true
end
