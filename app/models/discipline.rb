class Discipline
  include Mongoid::Document

  field :code, type: String
  field :name, type: String


  validates_presence_of :name, :code

  validates_uniqueness_of :name, case_sensitive: false
  validates_uniqueness_of :code, case_sensitive: false

  index :name, unique: true
  index :code, unique: true

  has_many :students
  has_many :projects do
    def search(search)
      # TODO: find an elegant way to do this without duplicading code
      if ! search.blank?
        where(title: /.*#{search}.*/i)
      else
        all
      end
    end
  end
end
