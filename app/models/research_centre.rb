class ResearchCentre
  include Mongoid::Document

  field :code, type: String
  field :title, type: String

  validates_presence_of :code, :title
  validates_uniqueness_of :code, case_sensitive: false
  validates_uniqueness_of :title, case_sensitive: false

  has_many :supervisors

  index :code, unique: true
end
