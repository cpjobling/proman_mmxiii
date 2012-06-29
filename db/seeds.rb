require 'CSV'

puts 'EMPTY THE MONGODB DATABASE'
Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :student_or_staff_number => 123456, :email => 'user@example.com', :password => 'please', :password_confirmation => 'please'
user.confirm!
puts 'New user created: ' << user.email

puts 'create routes collection'
CSV.foreach('data/routes.csv',:headers => true) do |row|
  route = Route.create! :route_code => row['SCE_ROUC'], :route_name => row['ROU_NAME']
  puts "Route '" << route.route_name << " (" << route.route_code << ")' created"
end
