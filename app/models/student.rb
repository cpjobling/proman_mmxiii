class Student < Person
  include Mongoid::Document


  field :student_number, :type => Integer
  field :course, type: String
  field :grade, type: Float
  field :level_last_year, type: String
  field :progression, type: String
  field :supp_count, type: Integer
  # TODO: find out MongoID version of Text
  field :comments, type: String

  validates_presence_of :discipline, :course, :student_number
  # TODO: make degree scheme an embedded object

  belongs_to :discipline

  validates_numericality_of :student_number, :only_integer => true, :message => "Enter the 6 digit number that you'll find on your student card, ommitting any leading zeros."
  validates_uniqueness_of :student_number

  attr_accessible :student_number, :course, :grade, :level_last_year, 
                  :progression, :supp_count, :comments

  index :student_number, unique: true
end
