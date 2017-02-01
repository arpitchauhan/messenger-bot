# == Schema Information
#
# Table name: messages
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
  factory :message do
    association :sender, factory: :entity
    association :recipient, factory: :entity
    text { Faker::StarWars.quote }
    mid { Utils::Random.large_natural_number }
    seq { Utils::Random.small_natural_number(:integer) }
    timestamp { Utils::Random.time(:before_now) }
  end
end
