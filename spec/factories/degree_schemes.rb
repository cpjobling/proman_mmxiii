FactoryGirl.define do
  factory :degree_scheme do
    program_code 'BEHE3XX'
    course_title 'Bachelor of Engineering (Hons)'
  end
  
  factory :course do
    route_code 'XMECS'
    route_name 'Mechanical Engineering Single'
    title 'Mechanical Engineering'
    university_course_title 'Mechanical Engineering 3yr FULL TIME'
    degree 'BEng'
  end
end
