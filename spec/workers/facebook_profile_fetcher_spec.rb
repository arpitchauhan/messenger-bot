require 'rails_helper'

RSpec.describe 'FacebookProfileFetcher' do
  before :each do
    allow_any_instance_of(FacebookService).to receive(:initialize)
    allow_any_instance_of(FacebookService).to receive(:get_object).and_return({ 'name' => 'John' })
    @profile = create(:facebook_profile, name: nil)
    @worker = FacebookProfileFetcher.new
  end

  it 'fetches the name of the profile correctly' do
    @worker.perform(@profile.id)
    expect(@profile.reload.name).to eq('John')
  end
end
