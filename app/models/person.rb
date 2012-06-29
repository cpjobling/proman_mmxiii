class Person
  include Mongoid::Document

  field :title,          :type => String
  field :forename1,      :type => String
  field :forename2,      :type => String, :default => ''
  field :forename3,      :type => String, :default => ''
  field :preferred_name, :type => String, :default => ''
  field :surname,        :type => String
  
  validates_presence_of :title, :forename1, :surname
  
  def name
    preferred_name || forename1
  end
  
  def full_name
    "#{title} #{forename1} #{forename2} #{forename3} #{surname}".squeeze(" ")
  end
  
  def sortable_name
    "#{surname}, #{forename1} #{forename2} #{forename3} ".squeeze(" ").strip
  end
  
  def formal_address
    "#{title} #{surname}"
  end
end