class BotController < ApplicationController

  def get_webhook
    raise 'Token not set' if ENV['webhook_token'].blank?
    if params['hub.verify_token'] == ENV['webhook_token']
      render plain: params['hub.challenge']
    else
      render plain: 'error'
    end
  end

  def post_webhook
    render status: 200
  end
end
