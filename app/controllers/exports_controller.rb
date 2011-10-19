import java.sql.Statement
import java.sql.Connection
import java.sql.SQLException
import java.sql.Types
import java.sql.DriverManager
require 'ruby_plsql'

class ExportsController < ApplicationController
	skip_before_filter :authenticate
	def index
		DriverManager.registerDriver Java::oracle.jdbc.driver.OracleDriver.new
		plsql.connection = DriverManager.getConnection()	
	  	
	  	#export code is courtesy of Scott Becker: http://synthesis.sbecker.net/articles/2007/06/07/how-to-generate-csv-files-in-rails
	  	@rsvps = Rsvp.all
	  	@rsvps.sort! {|a,b| a.section.name <=> b.section.name }
	  	
	  	csv_string = FasterCSV.generate do |csv|
	      	# header row
		  	csv << ["Last Name", "First Name","Student", "Section", "Shirt Size"]	
		    
		    # data rows
		    @rsvps.each do |rsvp|
			    @first
			    @last
			    #get display name....			
				@first = plsql.select_first("SELECT first_name FROM people WHERE username='"+rsvp.user.username+"'")
				@last = plsql.select_first("SELECT last_name FROM people WHERE username='"+rsvp.user.username+"'")			
	
				csv << [@last, @first, rsvp.user.username, rsvp.section.name, rsvp.shirt_size]			
		    end
	  	end
	
	  	send_data csv_string,
	            :type => 'text/csv; charset=iso-8859-1; header=present',
	            :disposition => "attachment; filename=ConvocationRSVPs.csv"  	
	end
	
	
end