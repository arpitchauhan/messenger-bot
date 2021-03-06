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

class Facebook::Page < Facebook::Profile

  def self.mine
    find_by!(facebook_id: FacebookPageInfo::PAGE_ID)
  end
end
