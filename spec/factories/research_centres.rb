FactoryGirl.define do
  sequence(:rc_code) { |n| "rc#{n}"}
  sequence(:rc_name) { |n| "Research Centre #{n}"}
  factory :research_centre do
    code { generate(:rc_code) }
    name { generate(:rc_name) }
  end
end