class DegreeScheme
  include Mongoid::Document
  
  field :program_code, :type => String
  field :course_title, :type => String, :unique => true
  has_many :courses
  
  validates_uniqueness_of :program_code, :case_sensitive => false
  index :program_code
end
