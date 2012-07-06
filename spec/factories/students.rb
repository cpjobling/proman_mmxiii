FactoryGirl.define do
  factory :student do
    student_or_staff_number 123456
    # name 'Test User'
    email 'example@example.com'
    password 'please'
    password_confirmation 'please'
    # required if the Devise Confirmable module is used
    confirmed_at Time.now
    title 'Mr'
    forename1 'Charles'
    forename2 'Philip'
    forename3 'Arthur George'
    surname 'Windsor'
    preferred_name 'Chuck'
    discipline 'Mechanical Engineering'
  end
end
