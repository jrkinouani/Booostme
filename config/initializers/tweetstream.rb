require 'tweetstream'

TweetStream.configure do |config|
  config.consumer_key       = 'a1XlNSOLUHroZAINgG2FF6sIf'
  config.consumer_secret    = 'n6w09UqByeYmaN6D6K5ZUwdsuP3MWXpbhYLBSyl9QhEM50MZO3'
  config.oauth_token        = '182766751-JlJrh7kpEQXpigpKNijeebQ3oEna5PgC0rnEeEGo'
  config.oauth_token_secret = 'mZVXRDW4lYRnytZep9PoX930v8IqCqBHG7OlgE4W9i93n'
  config.auth_method        = :oauth
end

Thread.new do
  TweetStream::Client.new.track('#booostme') do |status|
    user = nil
    status.hashtags.each do |hashtag|
      user = User.find_by_login(hashtag.text)
      break if user
    end

    if user
      boost = Boost.new({content: status.text})
      boost.img = status.media[0].media_url_https.to_s if status.media.size > 0

      if boost.save
        user.tasks.last.boosts << boost
      end
    end
  end
end
