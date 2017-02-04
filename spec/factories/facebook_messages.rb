# == Schema Information
#
# Table name: facebook_messages
#
#  id           :integer          not null, primary key
#  sender_id    :integer
#  recipient_id :integer
#  text         :text
#  mid          :string
#  seq          :integer
#  timestamp    :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :facebook_message do
    association :sender, factory: :facebook_profile
    association :recipient, factory: :facebook_profile
    text { Faker::StarWars.quote }
    mid { Utils::Random.large_natural_number }
    seq { Utils::Random.small_natural_number(:integer) }
    timestamp { Utils::Random.time(:before_now) }
  end
end
