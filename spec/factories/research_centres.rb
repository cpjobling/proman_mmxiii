FactoryGirl.define do
  sequence(:rc_code) { |n| "rc#{n}"}
  sequence(:title) { |n| "Research Centre #{n}"}
  factory :research_centre do
    code { generate(:rc_code) }
    title { generate(:name) }
  end
end