class Location < ActiveRecord::Base
	has_many :sections
	
	def getAvailableSections
		@sections = Sections.all 
		@col = Array.new 
		
		@sections.each do |section|
			@col << section if section.hasSeatsAvailable
		end
		
		return @col
	end
end
