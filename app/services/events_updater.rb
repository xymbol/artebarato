# frozen_string_literal: true

class EventsUpdater
  USER = 'ArteBArato_'

  class << self
    delegate :update, to: :new
  end

  attr_reader :client

  def initialize(client = build_client)
    @client = client
  end

  def call
    user_timeline(USER).each do |tweet|
      next if reply_tweet? tweet
      update_event_with tweet
    end
  end
  alias update call

  private

  delegate :status, :user_timeline, to: :client

  def build_client
    Twitter::REST::Client.new do |config|
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
    end
  end

  def extended_status(tweet_id)
    status tweet_id, tweet_mode: 'extended'
  end

  def extended_text(tweet)
    if (status = extended_status tweet.id)
      if status.truncated? && status.attrs[:extended_tweet]
        status.attrs[:extended_tweet][:full_text]
      else
        status.attrs[:text] || status.attrs[:full_text]
      end
    end
  end

  def match_category(text)
    if (name = parse_name(text))
      Category.find_or_create_by name: parse_name(text)
    end
  end

  def parse_name(text)
    case text
    when /\A\[([[:alpha:]]+)\]/ then Regexp.last_match(1).titleize
    when /\A\#([[:alpha:]]+)/ then Regexp.last_match(1).titleize
    end
  end

  def reply_tweet?(tweet)
    tweet.in_reply_to_status_id.present?
  end

  def update_event_with(tweet)
    event = Event.find_or_initialize_by tweet_id: tweet.id
    event.update! \
      category: match_category(tweet.text),
      tweet_created_at: tweet.created_at,
      tweet_text: extended_text(tweet)
  rescue ActiveRecord::RecordInvalid
    puts "Failed to create event: #{tweet}"
  end
end
