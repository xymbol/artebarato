# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :events

  scope :ordered, -> { order :name }

  validates :name, uniqueness: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  def self.navigable(number)
    navigable_ids = joins(:events).group(:id)
                                  .order('count_all desc')
                                  .count
                                  .take(number)
                                  .map &:first
    find navigable_ids
  end
end
