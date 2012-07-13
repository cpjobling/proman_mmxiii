require 'CSV'

puts 'EMPTY THE MONGODB DATABASE'
Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :student_or_staff_number => 123456, :email => 'user@example.com', :password => 'please', :password_confirmation => 'please'
user.confirm!
puts 'New user created: ' << user.email

puts 'CREATE DEGREE SCHEMES COLLECTION'
CSV.foreach('data/degree_schemes.csv',:headers => true) do |row|
  ds = DegreeScheme.create! :program_code => row['SCE_PRGC'], :course_title => row['CRS_TITL']
  puts "Degree scheme '" << ds.course_title << " [" << ds.program_code << "]' created"
end

puts 'CREATE ROUTES COLLECTION'
CSV.foreach('data/routes.csv',:headers => true) do |row|
  course = Course.create!(
    :route_code => row['SCE_ROUC'],
    :route_name => row['ROU_NAME'],
    :degree => row['DEGREE'],
    :title => row['TITLE'],
    :university_course_title => row['UWS_CRS_TITLE'])
  course.degree_scheme = DegreeScheme.first(conditions: { program_code: row['SCE_PRGC']})
  course.save!
  puts "Course '" << course.route_name << " (" << course.route_code << ")' created"
end

puts 'CREATE RESEARCH CENTRES'
research_centres = {
  'MNC' =>  'Multidisciplinary Naonotechnology Centre',
  'C2EC' => 'Civil and Computational Engineering Centre',
  'MRC' =>  'Materials Research Centre',
  'SES' =>  'Sport and Exercise Science'
}

research_centres.each do |code, name|
  rc = ResearchCentre.create!(code: code, name: name)
  puts "Research Centre '#{rc.code}: #{rc.name}' created"
end

puts 'CREATE DISCIPLINE LISTS'
puts 'CREATE ROUTES COLLECTION'
CSV.foreach('data/disciplines.csv',:headers => true) do |row|
  discipline = Discipline.create!(
    :name => row['For Discipline'],
    :code => row['Code']
  )
  puts "Discipline '#{discipline.name} (#{discipline.code})' created"
end


