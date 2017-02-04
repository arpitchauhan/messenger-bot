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

class Facebook::Message < ApplicationRecord
  belongs_to :sender, class_name: 'Facebook::Profile'
  belongs_to :recipient, class_name: 'Facebook::Profile'
end
