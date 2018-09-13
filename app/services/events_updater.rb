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
    user_timeline.each do |tweet|
      update_event_with tweet
    end
  end
  alias update call

  private

  def build_client
    Twitter::REST::Client.new do |config|
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
    end
  end

  def extended_text(tweet)
    if tweet.truncated? && tweet.attrs[:extended_tweet]
      tweet.attrs[:extended_tweet][:full_text]
    else
      tweet.attrs[:text] || tweet.attrs[:full_text]
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

  def update_event_with(tweet)
    text = extended_text tweet
    event = Event.find_or_initialize_by tweet_id: tweet.id
    event.update! \
      category: match_category(text),
      tweet_created_at: tweet.created_at,
      tweet_source: tweet.to_json,
      tweet_text: text
  rescue ActiveRecord::RecordInvalid
    puts "Failed to create event: #{tweet}"
  end

  def user_timeline
    client.user_timeline USER,
                         exclude_replies: true,
                         include_rts: false,
                         trim_user: true,
                         tweet_mode: 'extended'
  end
end
