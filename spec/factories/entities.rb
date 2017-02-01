# == Schema Information
#
# Table name: entities
#
#  id          :integer          not null, primary key
#  facebook_id :string
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :entity do
    facebook_id { Utils::Random.large_natural_number }

    factory :page do
      type 'Page'
    end

    factory :profile do
      type 'Profile'
    end
  end
end
