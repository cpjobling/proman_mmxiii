class ResearchCentre
  include Mongoid::Document

  field :code, type: String
  field :name, type: String

  validates_presence_of :code, :name
  validates_uniqueness_of :code, case_sensitive: false
  validates_uniqueness_of :name, case_sensitive: false

  has_many :supervisors

  index :code, unique: true
end
