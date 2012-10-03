
require 'csv'

# Series of tasks for greating group definition files
# for Blackboard 

namespace :admin do
  namespace :bb_groups do
    desc "Create tutor groups"
    task :tutor_csv => [:environment] do |t|
      projects = Project.assigned
      projects.each do |p|
        row = [p.student_number,"#{p.supervisor.sortable_informal_name_and_title}'s Students"].to_csv
        puts row
      end
    end
    desc "Add students to research centre groups" 
    task :rc_csv => [:environment] do |t|
      projects = Project.assigned
      projects.each do |p|
        row = [p.student_number,p.research_centre_name].to_csv
        puts row
      end
    end
    desc "Add supervisors to research centre groups" 
    task :supervisor_groups => [:environment] do |t|
      supervisors = Supervisor.all
      supervisors.each do |s|
        row = [s.bbusername,s.research_centre.name].to_csv
        puts row
      end
    end
  end
end
