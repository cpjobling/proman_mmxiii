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
        :student_number, :student_name, :available

  validates_presence_of :title, :description, :discipline, :supervisor

  belongs_to :discipline
  belongs_to :supervisor

  def students_own_project?
    students_own_project
  end

  def available?
    available
  end

  def allocated?
    allocated
  end

  def research_centre
    return supervisor.research_centre
  end

  def research_centre_name
    supervisor.research_centre_name
  end

  def research_centre_code
    supervisor.research_centre_code
  end

  def code
    return "#{PREFIX}#{'%03d' % pid}"
  end

  def status
    if available? 
      return "Available"
    else
      return "Not available"
    end
  end

  def supervisor_email
    supervisor.email
  end

  def supervisor_name
    supervisor.full_name
  end

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
end