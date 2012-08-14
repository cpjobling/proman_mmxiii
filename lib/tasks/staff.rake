
require 'csv'
require 'mongoid'

# We normalise emails by making them lower case. Also as our email domain 
# may be abbreviated by staff and students as `swan.ac.uk` for consistency
# I've decided it should be `swansea.ac.uk`. This method should 
# probably also check that the email is from the correct domain in the first place.
def normalize_email_address email_address
  email_address.downcase.sub(/swan\.ac\.uk/,'swansea.ac.uk')
end

namespace :admin do
  namespace :staff do
    desc "Populate database with staff records from CSV file"
    task :add_from_csv, [:csv_file] => [:environment] do |t, args|
      args.with_defaults(:csv_file => '$HOME/Dropbox/projects/2012-2013/data/csv/staff.csv')
      count = 0
      puts 'ADDING STAFF'
      CSV.foreach(args[:csv_file],:headers => true) do |row|
        begin
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
            :email => normalize_email_address(row['email'])
          )
          count += 1
          supervisor.confirmed_at = Time.now
          supervisor.research_centre = the_rc
          supervisor.save!
          supervisor.reload
          puts "Supervisor '#{supervisor.full_name} (SN #{supervisor.staff_number} - BB #{supervisor.bbusername})' added to #{supervisor.research_centre.code}"
        rescue
        end
      end
      puts "Added #{count} new staff records"
    end

    desc "Add supervisor role"
    task :add_supervisor_role => :environment do |t, args|
      supervisors = Supervisor.all
      supervisors.each do |supervisor|
        begin
          supervisor.roles << :supervisor
          supervisor.save!
          puts "Added supervisor role to #{supervisor.full_name}'s record"
        rescue
          puts "WARNING: suervisor role not added to #{supervisor.full_name}'s record"
        end
      end
    end
  end
end