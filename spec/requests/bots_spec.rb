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
end
