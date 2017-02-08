class FacebookProfileFetcher
  include Sidekiq::Worker
  sidekiq_options queue: 'facebook_profile_fetcher', retry: 2, backtrace: true

  def perform(profile_id)
    profile = Facebook::Profile.find(profile_id)
    name = FacebookService.new.get_name_of_object(profile.facebook_id)
    profile.update!(name: name)
  end
end
