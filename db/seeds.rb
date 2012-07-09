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

research_centres.each do |code, title|
  rc = ResearchCentre.create!(code: code, title: title)
  puts "Research Centre '#{rc.code}: #{rc.title}' created"
end


puts 'ADD STAFF'
CSV.foreach(ENV['STAFF'],:headers => true) do |row|
  the_rc = ResearchCentre.first(conditions: { code: row['centre']})
  supervisor = Supervisor.create!(
      :title => row['title'],
      :forename1 => row['first_name'],
      :forename2 => row['initials'],
      :surname => row['last_name'],
      :preferred_name => row['preferred_name'],
      :password => "%07d" % row['staff_number'],
      :password_confirmation => "%07d" % row['staff_number'],
      :staff_number => row['staff_number'],
      :bbusername => row['bbusername'],
      :email => row['email']
    )
  supervisor.confirmed_at = Time.now
  supervisor.research_centre = the_rc
  supervisor.save!
  supervisor.reload
  puts "Supervisor '#{supervisor.full_name} (SN #{supervisor.staff_number} - BB #{supervisor.bbusername})' added to #{supervisor.research_centre.code}"
end

