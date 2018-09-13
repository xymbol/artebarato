# frozen_string_literal: true

require 'test_helper'

class EventsUpdaterTest < ActiveSupport::TestCase
  test 'update creates event' do
    stub_user_timeline 'user_timeline.json'
    assert_difference 'Event.count' do
      EventsUpdater.update
    end
  end

  test 'update with truncated text' do
    stub_user_timeline 'truncated.json'
    assert_difference 'Event.count' do
      EventsUpdater.update
    end
  end

  test 'update with brackets tag' do
    stub_user_timeline 'brackets_tag.json'
    assert_difference 'Event.count' do
      EventsUpdater.update
    end
  end

  test 'update without category' do
    stub_user_timeline 'no_category.json'
    assert_output(/Failed/) do
      EventsUpdater.update
    end
  end

  def response_hashes(fixture_name)
    {
      body: file_fixture(fixture_name).open,
      headers: {
        'Content-type' => 'application/json'
      },
      status: 200
    }
  end

  def stub_user_timeline(fixture_name)
    stub_request(:get, 'https://api.twitter.com/1.1/statuses/user_timeline.json')
      .with(query: {
              exclude_replies: 'true',
              include_rts: 'false',
              screen_name: 'ArteBArato_',
              trim_user: 'true',
              tweet_mode: 'extended'
            })
      .to_return(response_hashes(fixture_name))
  end
end
