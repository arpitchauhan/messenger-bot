module FacebookDefaultSettings
  APP_ID = ENV['facebook_app_id'].freeze
  APP_SECRET = ENV['facebook_app_secret'].freeze
end

Koala::Facebook::OAuth.class_eval do

  alias_method :initialize_without_default_settings, :initialize
  def initialize_with_default_settings(*args)
    case args.size
      when 0, 1
        unless FacebookDefaultSettings::APP_ID && FacebookDefaultSettings::APP_SECRET
          raise "App ID and/o App secret are not specified in config"
        end
        initialize_without_default_settings(FacebookDefaultSettings::APP_ID.to_s,
                                            FacebookDefaultSettings::APP_SECRET.to_s,
                                            args.first)
      when 2, 3
        initialize_without_default_settings(*args)
      else
        raise "At most 3 arguments allowed"
    end
  end

  alias_method :initialize, :initialize_with_default_settings
end

