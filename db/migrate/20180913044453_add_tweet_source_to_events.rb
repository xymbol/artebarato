class AddTweetSourceToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :tweet_source, :text
  end
end
