require 'csv'
require 'yaml'
#require 'pry'

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
    desc "produce stupervisor's view of project allocation"
    task :supervisor_list => [:environment] do |t|
      desired_headings = [
        'PID',
        'Project Title (If Known)',
        'Supervisor',
        'Supervisor Email',
        'Student Name',
        'Number',
        'Discipline',
        'Email',
        'Own Project?',
        'RC Code'
      ]
      result = File.open('/tmp/staff-view.csv','w')
      result.puts desired_headings.to_csv
      Project.assigned.each do |p|
        data = ['p-2012-' + p.pid.to_s]
        data << p.title
        data << p.supervisor.sortable_name
        data << p.supervisor.email
        data << p.student_name
        data << p.student_number
        data << p.discipline.name
        data << p.student_number.to_s + '@swansea.ac.uk'
        data << p.students_own_project
        data << p.supervisor.research_centre.code
        result.puts data.to_csv
      end
      result.close
    end
  end
end