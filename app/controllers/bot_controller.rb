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
    if params[:object] == 'page'
      params[:entry].each do |entry|
        page = Facebook::Page.find_or_create_by!(facebook_id: entry[:id])
        entry[:messaging].each do |message|
          sender = Facebook::User.find_or_create_by!(facebook_id: message[:sender][:id])
          recipient_facebook_id = message[:recipient][:id]
          # check if page is recipient
          if page.facebook_id == recipient_facebook_id
            time = Utils::Facebook.convert_timestamp_to_time(message[:timestamp])
            message = Facebook::Message.create!(sender: sender,
                                                recipient: page,
                                                timestamp: time,
                                                text: message[:message][:text],
                                                seq: message[:message][:seq],
                                                mid: message[:message][:mid])
            Talker.new(sender).reply(to: message)
          else
            Rails.logger.warn "Facebook::Page id #{page.facebook_id} not same as recipient id #{recipient_facebook_id}"
          end
        end
      end
    end
  rescue => e
    Rails.logger.error "Error occurred: #{e.class} -- #{e.message}"
    Rails.logger.error "Backtrace: #{e.backtrace}"
  ensure
    render status: 200
  end
end
