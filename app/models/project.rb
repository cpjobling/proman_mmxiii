class Project
  include Mongoid::Document
  include Mongoid::Timestamps

  PREFIX = 'p-2012-'

  field :title, type: String
  field :description, type: String
  field :associated_with, type: Array
  field :cross_disciplinary_theme, type: String
  field :special_requirements, type: String
  field :available, type: Boolean, default: true
  field :students_own_project, type: Boolean, default: false
  field :student_number, type: Integer
  field :student_name, type: String
  field :allocated, type: Boolean, default: false

  auto_increment :pid

  attr_accessible :code, :title, :description, :associated_with, 
        :cross_disciplinary_theme, :special_requirements, :students_own_project,
        :student_number, :student_name, :available, :allocated

  validates_presence_of :title, :description, :discipline, :supervisor

  belongs_to :discipline
  belongs_to :supervisor

  scope :unassigned, where(:allocated.ne => true, available: true)
  scope :assigned, where(allocated: true)
  scope :unavailable, where(:available.ne => true)
  scope :selectable, where(available: true, :allocated.ne => true)

  
  def students_own_project?
    students_own_project
  end

  def available?
    available && ! allocated
  end

  def allocated?
    allocated
  end

  delegate :research_centre, :research_centre_name, :research_centre_code, to: :supervisor

  def code
    return "#{PREFIX}#{'%03d' % pid}"
  end

  delegate :name, to: :discipline, prefix: true

  def status
    if available
      if allocated
        return "Allocated to #{student_number}"
      else
        if students_own_project
          return "Defined by #{student_number}"
        else
          return "Available"
        end
      end
    else
      return "Not available"
    end
  end

  delegate :email, :sortable_name, :full_name, :sortable_name_and_title, :login, to: :supervisor, prefix: true
  alias :supervisor_name :supervisor_full_name

  def self.column_names
    self.fields.collect { |field| field[0] }
  end

  def self.search(search)
    if ! search.blank?
      where(title: /.*#{search}.*/i)
    else
      all
    end
  end

  def allocate_to(number, name = "")
    # TODO: use real student record with discipline check
    update_attributes!(allocated: true, student_number: number, student_name: name, available: true)
    logger.info "Allocated project #{code} to student #{student_number}"
  end

  def deallocate
    unless students_own_project
      update_attributes!(allocated: false, student_number: nil, student_name: nil)
    else
      # Shouldn't remove student data from student-defined projects
      update_attributes!(allocated: false)
    end
  end

  def allocated_to
    # TODO: return student!
    { name: student_name, number: student_number }
  end

  def make_unavailable
    update_attributes!(available: false)
    logger.info "Project #{code} has been made unavailable"
  end

  def make_available
    update_attributes!(available: true)
    logger.info "Project #{code} has been made available"
  end

  def change_discipline(code)
    return if code.blank? || self.allocated? || self.students_own_project?
    old_discipline = self.discipline
    new_discipline = Discipline.for_code(code)
    return if new_discipline.nil?
    self.discipline = new_discipline
    self.discipline.save!
    logger.info "Discipline for project #{code} has been changed from #{old_discipline.name} to #{discipline.name}"
  end

  def self.by_id(pid)
    Project.where(pid: pid).first
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      header = ["Code","Title","Status","Available?","Student number","Student name","Discipline",
                "Own project?","Allocated?","Supervisor",
                "Supervisor's email","Research Centre","RC code"]
      csv << header
      all.each do |project|
        csv << [
          project.code,
          project.title,
          project.status,
          project.available,
          project.student_number,
          project.student_name,
          project.discipline_name,
          project.students_own_project,
          project.allocated,
          project.supervisor_sortable_name,
          project.supervisor_email,
          project.research_centre_name,
          project.research_centre_code
        ]
      end
    end
  end

  def self.tutor_list_as_csv(options = {})
    projects = assigned
    CSV.generate(options) do |csv|
      header = ["Student No","Login","Supervisor","Student","Discipline"]
      csv << header
      projects.each do |project|
        csv << [
                project.student_number,
                project.supervisor_login,
                project.supervisor_full_name,
                project.student_name,
                project.discipline_name
               ]
      end
    end
  end

  def self.assigned_to_csv(options={})
    projects = assigned
    CSV.generate(options) do |csv|
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
      csv << desired_headings
      projects.each do |p|
        csv << [
                p.code,
                p.title,
                p.supervisor_sortable_name,
                p.supervisor_email,
                p.student_name,
                p.student_number,
                p.discipline_name,
                p.student_number.to_s + '@swansea.ac.uk',
                p.students_own_project,
                p.research_centre_code
              ]
      end
    end
  end
end