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

  private

  def fetch_details_from_facebook!
    FacebookProfileFetcher.perform_async(id)
  end
end
