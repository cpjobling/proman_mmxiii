FactoryGirl.define do
  factory :supervisor do
    staff_number 123456
    bbusername 'engchuck'
    # name 'Test User'
    email 'example@example.com'
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
    research_centre 'C2EC'
  end
end
