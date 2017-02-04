require 'rails_helper'

RSpec.describe 'Bots', type: :request do
  describe 'get /get_webhook' do
    it 'returns challenge when token is correct' do
      ClimateControl.modify webhook_token: 'token' do
        get '/webhook?hub.verify_token=token&hub.challenge=starwars'
        expect(response).to have_http_status(200)
        expect(response.body).to eq('starwars')
      end
    end
  end

  describe 'post /post_webhook' do
    before :each do
      @payload = {
        'object' => 'page',
        'entry' => [
          {
            'id' => '732979013420893',
            'time' => 1_485_898_512_693,
            'messaging' => [
              {
                'sender' => { 'id' => '1131196886949901' },
                'recipient' => { 'id' => '732979013420893' },
                'timestamp' => 1_485_896_474_420,
                'message' => {
                  'mid' => 'mid.1485896474420:60c6dc8842',
                  'seq' => 1_315_338,
                  'text' => 'Message text!'
                }
              }
            ]
          }
        ]
      }

      post '/webhook', params: @payload
    end

    it 'creates user properly' do
      expect(Facebook::User.count).to eq(1)
      user = Facebook::User.first
      expect(user.facebook_id).to eq('1131196886949901')
    end

    it 'creates page properly' do
      expect(Facebook::Page.count).to eq(1)
      user = Facebook::Page.first
      expect(user.facebook_id).to eq('732979013420893')
    end

    it 'creates message properly' do
      expect(Facebook::Message.count).to eq(1)
      message = Facebook::Message.first
      expect(message.text).to eq('Message text!')
      expect(message.seq).to eq(1_315_338)
      expect(message.timestamp.to_i * 1000).to eq(1_485_896_474_000) # last 3 digits are lost
      expect(message.sender).to eq(Facebook::User.last)
      expect(message.recipient).to eq(Facebook::Page.last)
    end
  end
end
