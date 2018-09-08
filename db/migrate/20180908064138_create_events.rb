class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :tweet_id
      t.datetime :tweet_created_at
      t.text :tweet_text
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
    add_index :events, :tweet_id
  end
end
