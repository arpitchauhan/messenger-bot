# == Schema Information
#
# Table name: facebook_profiles
#
#  id          :integer          not null, primary key
#  facebook_id :string
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string
#

class Facebook::Profile < ApplicationRecord
  has_many :sent_messages, class_name: 'Facebook::Message', foreign_key: :sender_id
  has_many :received_messages, class_name: 'Facebook::Message', foreign_key: :recipient_id

  validates :facebook_id, presence: true

  after_create :fetch_details_from_facebook!

  def messages_sent_to_my_page
    sent_messages.where(recipient: Facebook::Page.mine)
  end

  def messages_received_from_my_page
    received_messages.where(sender: Facebook::Page.mine)
  end

  private

  def fetch_details_from_facebook!
    FacebookProfileFetcher.perform_async(id)
  end
end
