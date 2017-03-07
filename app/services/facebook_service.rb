class FacebookService
  attr_reader :koala

  REDIS_APP_ACCESS_TOKEN_KEY = 'facebook_app_access_token'.freeze

  def initialize(app_access_token = get_app_access_token)
    @koala = Koala::Facebook::API.new(app_access_token, FacebookDefaultSettings::APP_SECRET)
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

  def send_message(facebook_identifier, message)
    facebook_id = facebook_identifier.is_a?(ActiveRecord::Base) ? facebook_identifier.facebook_id : facebook_identifier
    raise 'facebook_id is mandatory' unless facebook_id
    body = {
      'recipient' => {
        'id' => facebook_id
      }.to_json,

      'message' => {
        'text' => message
      }.to_json
    }
    make_call_as_page('me/messages', 'post', body)
  end

  def make_call_as_page(path, verb, options = {})
    args = options.reverse_merge('access_token' => page_access_token)
    Koala.make_request(path, args, verb)
  end

  private

  def get_app_access_token(force_refresh_of_token = false)
    if !force_refresh_of_token && $redis.exists(REDIS_APP_ACCESS_TOKEN_KEY)
      $redis.get(REDIS_APP_ACCESS_TOKEN_KEY)
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

  def page_id
    ENV['facebook_page_id'].freeze
  end

  def page_access_token
    ENV['facebook_page_access_token'].freeze
  end
end
