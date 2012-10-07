
require 'csv'

# In sharepoint created_by records are in form 'Surname, Initials.'
# and email is Initials.Surname@swansea.ac.uk 
def email_from_creator created_by
  names = created_by.split(' ')
  return "#{names[1]}#{names[0]}".downcase + "@swansea.ac.uk"
end

def allocate(p, pid, student_number, student_name)
  puts "Allocating project #{pid} #{p.title} to student #{student_number}"
  p.allocate_to(student_number, student_name)
end

$DISCIPLINE_COUNTER = Hash.new(0)

def count_project(for_discipline)
  $DISCIPLINE_COUNTER[for_discipline] += 1
end

namespace :admin do
  namespace :projects do
    desc "Populate database with project records from CSV file"
    task :add_from_csv, [:csv_file] => [:environment] do |t, args|
      args.with_defaults(:csv_file => ENV['HOME'] + '/Dropbox/projects/2012-2013/data/csv/projects.csv')
      count = 0
      puts 'ADDING PROJECTS'
      CSV.foreach(args[:csv_file],:headers => true,  :encoding => 'windows-1251:utf-8') do |row|
        #begin
          project = Project.new(
            title: row['Title'], 
            description: row['Description'],
            special_requirements: row['Special Requirements'],
            cross_disciplinary_theme: row['Cross disciplinary themes']
          )
          
          # Supervisor
          email = email_from_creator(row['Created By'])
          project.supervisor = Supervisor.first(conditions: 
            { email: email }
          )
          puts "#{email}: #{project.supervisor}"
          # Discipline
          for_discipline = row['For Discipline']
          count_project(for_discipline)
          project.discipline = Discipline.first(conditions: { name: for_discipline })

          # Override Rails Created-at date - data collected elsewhere
          project.created_at = row['Created'].to_time

          # Associated with an array of possibilities
          associated_with = row['This project is associated with']
          if associated_with 
            project.associated_with = row['This project is associated with'].split('; ')
          else
            project.associated_with = []
          end

          # Available?
          project_available = row['Project available?'].to_bool

          # Students own?
          students_own_project = row["Student's own project?"].to_bool
          if row["Student's own project?"].to_bool
            project.students_own_project = true
            project.student_number = row["Student's number"].to_i
            project.student_name = row["Student's name"]
          end
          project.save!
          count += 1
          puts "Project: '#{project.code} #{project.title}' by #{project.supervisor.full_name} for #{project.discipline.name} added"
          if project.students_own_project
            puts "This is a student defined project for #{project.student_name} (#{project.student_number})"
          end
        #rescue
          #puts "ERROR!"
        #end
      end
      puts "Added #{count} new project records"
      puts "Breakdown by discipline"
      puts $DISCIPLINE_COUNTER.to_yaml
    end


    desc "Batch allocate projects from csv file: need student number, (optional) student name, and pid"
    task :batch_allocate, [:csv_file] => [:environment] do |t, args|
      args.with_defaults(:csv_file => ENV['HOME'] + '/Dropbox/projects/2012-2013/data/csv/project-allocations.csv')
      count = 0
      problems = []
      puts 'BATCH ALLOCATING PROJECTS'
      CSV.foreach(args[:csv_file],:headers => true,  :encoding => 'windows-1251:utf-8') do |row|
        proposed_allocation = {
          student_number: row["Stu Code"],
          pid:            row["Allocation"],
          discipline:     row["Discipline"],
          student_name:   row["Name"],
          message:        nil
        }
        pid = proposed_allocation[:pid]
        p = Project.where(pid: pid).first
        if p.nil? 
          puts "WARNING: project pid not found ... skipping"
          proposed_allocation[:message] = "project #{pid} not found"
          problems.push { proposed_allocation }
          next
        end
        if p.discipline.name != proposed_allocation[:discipline]
          puts "WARNING: student's discipline '#{proposed_allocation[:discipline]}' does not match project #{pid} discipline '#{p.discipline.name}'"
          puts "Proceed anyway? [y/n]"
          answer = STDIN.gets.chomp
          if answer =~ /[yY]/
            allocate(p, pid, proposed_allocation[:student_number], proposed_allocation[:student_name])
            count += 1
          else
            proposed_allocation[:message] = "project #{pid} not allocated to #{proposed_allocation[:student]} due to discipline mis-match"
            problems.push { proposed_allocation }
            next
          end
        else
          allocate(p, pid, proposed_allocation[:student_number], proposed_allocation[:student_name])
          count += 1
        end
      end
      puts "BATCH ALLOCATION: #{count} projects allocated successfully"
      if problems
        puts "At end of allocation the following records had problems please review"
        puts "Please review these problems:\n" + problems.to_yaml
      end
    end

    desc "Download Projects as CSV file"
    task :download_as_csv => [:environment] do |t|
      projects = Project.asc(:pid)
      puts projects.to_csv
    end

    desc "Download tutor list as CSV file"
    task :tutor_csv => [:environment] do |t|
      puts Project.tutor_list_as_csv
    end

  end
end
