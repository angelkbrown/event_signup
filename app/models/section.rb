class Section < ActiveRecord::Base
  belongs_to :location
  
  def hasSeatsAvailable
  	@rsvps = Rsvp.count(:all, :conditions => ['section_id = ?', self.id ])
  	if(@rsvps < self.max_seats)
  		return true
  	else
  		return false
  	end
  end
  
end
