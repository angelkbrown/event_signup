# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'openssl'
require 'base64'
require 'cgi'

class ApplicationController < ActionController::Base
  before_filter :authenticate
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def authenticate
  	@username = "newuser"
  	$current_username = "newuser"
	return true
  end  

end
