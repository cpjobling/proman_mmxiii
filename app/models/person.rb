class Person < User
  include Mongoid::Document

  field :title,          :type => String
  field :forename1,      :type => String
  field :forename2,      :type => String, :default => ''
  field :forename3,      :type => String, :default => ''
  field :preferred_name, :type => String, :default => ''
  field :surname,        :type => String
  field :date_of_birth,  :type => String # format dd/mm/yyyy

  validates_presence_of :title, :forename1, :surname
  validates_format_of :date_of_birth, with: /\A\d{2}\/\d{2}\/\d{4}\z/,
                      allow_blank: true, message: "should match dd/mm/yyyy"

  def name
    if preferred_name.blank?
      forename1
    else
      preferred_name
    end
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
