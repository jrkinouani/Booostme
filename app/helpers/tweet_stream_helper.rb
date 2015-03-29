module TweetStreamHelper

  def track_tweet(key_word)
    Thread.new do
      TweetStream::Client.new.track(key_word) do |status|
        puts "#{status.text}"
      end
    end
  end

end
