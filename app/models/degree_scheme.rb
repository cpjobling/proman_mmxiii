class DegreeScheme
  include Mongoid::Document
  
  field :program_code, :type => String
  field :course_title, :type => String, :unique => true
  has_many :courses
  
  validates_uniqueness_of :program_code, :case_sensitive => false
  validates_presence_of :program_code, :course_title
  index :program_code
end
