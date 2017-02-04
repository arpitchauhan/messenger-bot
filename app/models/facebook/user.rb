# == Schema Information
#
# Table name: facebook_profiles
#
#  id          :integer          not null, primary key
#  facebook_id :string
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Facebook::User < Facebook::Profile
end
