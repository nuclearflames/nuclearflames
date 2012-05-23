class TimelinesController < ApplicationController
  # GET /timelines
  # GET /timelines.xml
  
  def index
    @user = User.find(current_user)
    @timelines = Timeline.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @timelines }
    end
  end
  # GET /timelines/1
  # GET /timelines/1.xml
  def show
	@user = User.find(current_user)
	@timeline = Timeline.find(params[:id])
	
	if @timeline.user_id == current_user.id || @user.status == "Administrator"
	    respond_to do |format|
	      format.html # show.html.erb
	      format.xml  { render :xml => @timeline }
	    end
	else
	    redirect_to(:controller => "home", :action => "timeline")  
	end
  end

  # GET /timelines/new
  # GET /timelines/new.xml
  def new
    @timeline = Timeline.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @timeline }
    end
  end

  # GET /timelines/1/edit
  def edit
    @timeline = Timeline.find(params[:id])
    @user = User.find(current_user)
    
	if @timeline.user_id != current_user.id ||  @user.status != "Administrator"
		redirect_to(:action => "show")
	end
  end

  # POST /timelines
  # POST /timelines.xml
  def create
    @timeline = Timeline.new(params[:timeline])
	@timeline.user_id = current_user.id.to_i
	if @timeline.date == nil
		@timeline.date = Date.current
	end

  respond_to do |format|
      if @timeline.save
        format.html { redirect_to(:controller => "home", :action => "timeline") }
	flash[:notice] = 'Timeline was successfully created.'
        format.xml  { render :xml => @timeline, :status => :created, :location => @timeline }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @timeline.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /timelines/1
  # PUT /timelines/1.xml
  def update
    @timeline = Timeline.find(params[:id])
    respond_to do |format|
      if @timeline.update_attributes(params[:timeline])
        format.html { redirect_to(:controller => "home", :action => "timeline", :notice => 'Timeline was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @timeline.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /timelines/1
  # DELETE /timelines/1.xml
  def destroy
    @timeline = Timeline.find(params[:id])
	if @timeline.user_id == current_user.id || current_user.status == "Administrator"
		@timeline.destroy
	end

    respond_to do |format|
      format.html { redirect_to(:controller => "home", :action => "timeline") }
      format.xml  { head :ok }
    end
  end
end
