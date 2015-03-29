require 'rails_helper'

describe TweetStreamHelper do 
  it "connect to the twitter api" do
    expect(track_tweet("ruby").class).to eql(Thread)
  end
end
