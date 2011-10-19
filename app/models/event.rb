class Event < ActiveRecord::Base
  belongs_to :location
  has_many :sections, :through => :locations
end
