
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
  end
end