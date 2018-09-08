# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :events

  validates :name, uniqueness: true

  extend FriendlyId
  friendly_id :name, use: :slugged
end
