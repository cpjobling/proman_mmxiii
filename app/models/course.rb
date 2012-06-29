class Course
  include Mongoid::Document
  
  field :route_code, :type => String, :unique => true
  field :route_name, :type => String
  field :title, :type => String
  field :university_course_title, :type => String
  field :degree, :type => String
  belongs_to :degree_scheme
  
  validates_uniqueness_of :route_code, :case_sensitive => false
  index :route_code
end
