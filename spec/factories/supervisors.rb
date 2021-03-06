FactoryGirl.define do
  sequence(:email) { |n| "example#{n}@example.com" }
  sequence(:bbusername) { |n| "engchuck#{n}" }
  sequence(:staff_number) { |n| 100000 + n }
  factory :supervisor do
    staff_number { generate(:staff_number) }
    bbusername { generate(:bbusername) }
    # name 'Test User'
    email { generate(:email) }
    password 'please'
    password_confirmation 'please'
    # required if the Devise Confirmable module is used
    confirmed_at Time.now
    title 'Prof'
    forename1 'Charles'
    forename2 'Philip'
    forename3 'Arthur George'
    surname 'Windsor'
    preferred_name 'Chuck'
    research_centre
  end
end
    