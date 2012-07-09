class Supervisor < Person
  include Mongoid::Document

  field :staff_number, type: Integer
  field :bbusername, type: String

  attr_accessible :staff_number, :bbusername

  belongs_to :research_centre

  validates_presence_of :research_centre, :staff_number, :bbusername
  validates_uniqueness_of :staff_number
  validates_uniqueness_of :bbusername, case_sensitive: false

  index :staff_number, unique: true
  index :bbusername, unique: true
end
