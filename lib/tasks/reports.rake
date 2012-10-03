require 'csv'
require 'yaml'
require 'pry'

namespace :admin do
  namespace :reports do
    desc "Report project allocation numbers for supervisors"
    task :staff_allocation => [:environment] do |t|
      projects = Project.assigned
      supervisors = Hash.new
      puts "#{projects.count} projects allocated"
      projects.each do |p|
        sname = p.supervisor.sortable_name
        discipline = p.discipline.name
        if supervisors[sname]
          if supervisors[sname][:disciplines][discipline]
            supervisors[sname][:disciplines][discipline] += 1
          else
            supervisors[sname][:disciplines][discipline] = 1
          end
          supervisors[sname][:students] += 1
        else
          supervisors[sname] = { disciplines: { discipline => 1 }, students: 1 }
        end
      end
      puts supervisors.to_yaml
    end
  end
end