require 'rails_helper'

RSpec.describe "Bots", type: :request do
  describe "get /get_webhook" do
    it "returns challenge when token is correct" do
      ClimateControl.modify webhook_token: 'token' do
        get '/webhook?hub.verify_token=token&hub.challenge=starwars'
        expect(response).to have_http_status(200)
        expect(response.body).to eq('starwars')
      end
    end
  end

  describe "post /post_webhook" do
    before :each do
      @payload = { "object"=>"page",
                   "entry"=> [
                              {
                                "id" => "732979013420893",
                                "time" => 1485898512693,
                                "messaging" => [
                                                 {
                                                   "sender" => {"id"=>"1131196886949901"},
                                                   "recipient"=>{"id"=>"732979013420893"},
                                                   "timestamp"=>1485896474420,
                                                   "message"=> {
                                                                  "mid"=>"mid.1485896474420:60c6dc8842",
                                                                  "seq"=>1315338,
                                                                  "text"=>"kutie"
                                                               }
                                                  }
                                                ]
                               }
                              ]
                  }

    end

    it "creates message properly" do
      post '/webhook', @payload
      expect(response).to have_http_status(200)
    end
  end
end
