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

FactoryGirl.define do
  factory :facebook_profile do
    facebook_id { Utils::Random.large_natural_number }

    factory :facebook_page do
      type 'Facebook::Page'
    end

    factory :facebook_user do
      type 'Facebook::User'
    end
  end
end
