class RsvpsController < ApplicationController
  #validates_uniqueness_of(userid, eventid)
  # GET /rsvps
  # GET /rsvps.xml
  def index
    @rsvps = Rsvp.find_by_sql "select * from rsvps limit 0,50"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rsvps }
    end
  end

  # GET /rsvps/1
  # GET /rsvps/1.xml
  def show
    @rsvp = Rsvp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rsvp }
    end
  end

  # GET /rsvps/new
  # GET /rsvps/new.xml
  def new
    #check that user doesn't exist, then create them
    
  	@count = User.count(:conditions => ["username = ?", $current_username])
  	@user
  	if (@count <= 0)
	    @user = User.new
		@user.username = $current_username;
		@user.role = Role.find(:first, :conditions => ["name = ?", "Student"])
		@user.save
	else
		@user = User.find(:first, :conditions => ["username = ?", $current_username])
		#if user is admin, take them to export page
		if @user.role == Role.find(:first, :conditions => ["name = ?", "Administrator"])
		    @rsvps = Rsvp.find_by_sql "select * from rsvps limit 0,50"		
			render :controller => 'rsvps', :action => 'index' 
			return
		end

		#if user has already RSVP'd, take them to confirmation page
		@existing_rsvp = Rsvp.find(:first, :conditions => ["user_id = ?", @user.id])
		if(!@existing_rsvp.nil?)
			@rsvp = @existing_rsvp
			render "show"
			return 
		end
	end	
	
	@rsvp = Rsvp.new
	@rsvp.user = @user

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rsvp }
    end
  end

  # GET /rsvps/1/edit
  def edit
    @rsvp = Rsvp.find(params[:id])
  end

  # POST /rsvps
  # POST /rsvps.xml
  def create
  	#check that count(rsvps with same evid, sectionid) < section.max_seats
    @rsvp = Rsvp.new(params[:rsvp])

	@section = Section.find(@rsvp.section_id)
	@event = Event.find(@rsvp.event_id)
	@section_rsvps = Rsvp.count_by_sql ['select count(*) from rsvps where section_id = ? and event_id = ? ', @section.id, @event.id]
	@sect = Section.find(@rsvp.section.id)
	@max_seats = @sect.max_seats

	if(@section_rsvps < @max_seats)
	    respond_to do |format|
	      if @rsvp.save
	        format.html { redirect_to(@rsvp, :notice => 'Rsvp was successfully created.') }
	        format.xml  { render :xml => @rsvp, :status => :created, :location => @rsvp }
	      else
	        format.html { render :action => "new" }
	        format.xml  { render :xml => @rsvp.errors, :status => :unprocessable_entity }
	      end
	    end
	else
	    respond_to do |format|
        #flash[:notice] = 'Sorry, this section is full.'	    
	        format.html { render :action => "new" }
	        format.xml  { render :xml => @rsvp.errors, :status => :unprocessable_entity }		
		end
	end		

  end

  # PUT /rsvps/1
  # PUT /rsvps/1.xml
  def update
    @rsvp = Rsvp.find(params[:id])

    respond_to do |format|
      if @rsvp.update_attributes(params[:rsvp])
        format.html { redirect_to(@rsvp, :notice => 'Rsvp was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rsvp.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rsvps/1
  # DELETE /rsvps/1.xml
  def destroy
    @rsvp = Rsvp.find(params[:id])
    @rsvp.destroy

    respond_to do |format|
      format.html { redirect_to(rsvps_url) }
      format.xml  { head :ok }
    end
  end
  

end
