class Route
  include Mongoid::Document
  
  field :route_code, :type => String, :unique => true
  field :route_name, :type => String
  
  validates_uniqueness_of :route_code, :case_sensitive => false
  index :route_code
end
