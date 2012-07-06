class Supervisor < Person
  include Mongoid::Document

  field :research_centre, type: String

  validates_presence_of :research_centre
end
