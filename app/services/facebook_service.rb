class FacebookService

  REDIS_APP_ACCESS_TOKEN_KEY = 'facebook_app_access_token'.freeze

  def initialize
    @koala = Koala::Facebook::API.new(get_app_access_token, FacebookDefaultSettings::APP_SECRET)
  end

  def get_object(facebook_id)
    tries ||= 1
    @koala.get_object(facebook_id)
  rescue Koala::Facebook::AuthenticationError
    if tries == 1
      @koala = Koala::Facebook::API.new(get_app_access_token(true), FacebookDefaultSettings::APP_SECRET)
      tries += 1
      retry
    end
  end

  def get_name_of_object(facebook_id)
    get_object(facebook_id)['name']
  end

  private

  def get_app_access_token(force_refresh_of_token = false)
    if !force_refresh_of_token && $redis.exists(REDIS_APP_ACCESS_TOKEN_KEY)
      $redis.get(REDIS_APP_ACCESS_TOKEN_KEY, token)
    else
      token = Koala::Facebook::OAuth.new.get_app_access_token
      $redis.set(REDIS_APP_ACCESS_TOKEN_KEY, token)
      $redis.expire(REDIS_APP_ACCESS_TOKEN_KEY, redis_app_access_token_expire_seconds)
      token
    end
  end

  def redis_app_access_token_expire_seconds
    ENV['redis_app_access_token_expire_seconds'] || 6000
  end
end
