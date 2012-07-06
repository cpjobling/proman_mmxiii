class Supervisor < Person
  include Mongoid::Document

  belongs_to :research_centre

  validates_presence_of :research_centre
end
