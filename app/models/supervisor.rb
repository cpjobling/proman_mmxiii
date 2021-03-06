class Supervisor < Person
  include Mongoid::Document

  before_create do |supervisor| 
    supervisor.roles << :supervisor
  end

  field :staff_number, type: Integer
  field :bbusername, type: String

  attr_accessible :staff_number, :bbusername

  belongs_to :research_centre
  has_many   :projects

  validates_presence_of   :staff_number, :bbusername
  validates_uniqueness_of :staff_number
  validates_uniqueness_of :bbusername, case_sensitive: false

  index :staff_number, unique: true
  index :bbusername, unique: true

  delegate :name, :code, to: :research_centre, prefix: true   # => research_centre_code, research_centre_name

  def login
    @login ||= email.gsub(/@.*$/, "")
  end
end
