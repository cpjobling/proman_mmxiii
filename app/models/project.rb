class Project
  include Mongoid::Document
  include Mongoid::Timestamps

  PREFIX = 'p-2012-'

  field :title, type: String
  field :description, type: String
  field :associated_with, type: Array
  field :cross_disciplinary_theme, type: String
  field :special_requirements, type: String
  field :available, type: String, default: true
  field :students_own_project, type: Boolean, default: false
  field :student_number, type: Integer
  field :student_name, type: String

  auto_increment :pid

  attr_accessible :code, :title, :description, :associated_with, 
        :cross_disciplinary_theme, :special_requirements,
        :student_number, :student_name

  validates_presence_of :title, :description, :discipline, :supervisor


  belongs_to :discipline
  belongs_to :supervisor

  def students_own_project?
    students_own_project
  end

  def available?
    available
  end

  def research_centre
    return supervisor.research_centre
  end

  def code
    return "#{PREFIX}#{'%03d' % pid}"
  end
end