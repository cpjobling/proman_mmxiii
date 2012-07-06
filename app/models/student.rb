class Student < Person
  include Mongoid::Document

  field :course, type: String
  field :grade, type: Float
  field :level_last_year, type: String
  field :progression, type: String
  field :supp_count, type: Integer
  # TODO: find out MongoID version of Text
  field :comments, type: String

  validates_presence_of :discipline, :course
  # TODO: make degree scheme an embedded object

  belongs_to :discipline

end
