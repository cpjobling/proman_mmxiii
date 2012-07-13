FactoryGirl.define do
  sequence(:code) { |n| "mech#{n}" }
  sequence(:name) { |n| "Mechanical Engineering #{n}" }
  factory :discipline do
    name { generate(:name) }
    code { generate(:code) }
  end
end