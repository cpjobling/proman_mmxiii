FactoryGirl.define do
  sequence(:discipline_code) { |n| "mech#{n}" }
  sequence(:name) { |n| "Mechanical Engineering #{n}" }
  factory :discipline do
    name { generate(:name) }
    code { generate(:discipline_code) }
  end
end