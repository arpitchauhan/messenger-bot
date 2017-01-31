class BotController < ApplicationController
  def webhook
    raise 'Token not set' if ENV['webhook_token'].blank?
    if params['hub.verify_token'] == ENV['webhook_token']
      render plain: params['hub.challenge']
    else
      render plain: 'error'
    end
  end
end
