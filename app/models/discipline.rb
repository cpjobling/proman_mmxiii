class Discipline
  include Mongoid::Document

  field :name, type: String

  validates_presence_of :name

  validates_uniqueness_of :name, case_sensitive: false

  index :name, unique: true

  has_many :students
end
