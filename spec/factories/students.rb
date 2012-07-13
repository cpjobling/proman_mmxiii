FactoryGirl.define do
  factory :student do
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
    student_number 123456
    discipline
  end
end
