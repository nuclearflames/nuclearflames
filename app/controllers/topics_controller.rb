class TopicsController < ApplicationController
skip_before_filter :authorizeUser, :only => ['show', 'topicsList']
  # GET /topics
  # GET /topics.xml
  def index
    @topic = Topic.new
    @topics = Topic.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.xml
  def show
    @thred = Thred.new
    @topic = Topic.find(params[:id])
    @threads = @topic.threds
    session[:topic_id] = params[:id]
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
    @topic = Topic.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @user = User.find(current_user)
    @topic = Topic.find(params[:id])
    if @topic.user_id != current_user.id || @user.status != "Administrator"
	redirect_to(topic_path(@topic.id))
	flash[:notice] = "Can't Edit what aint urs!! :O"
    end
  end

  # POST /topics
  # POST /topics.xml
  def create
    @topic = Topic.new(params[:topic])
	@topic.user_id = current_user.id
    respond_to do |format|
      if @topic.save
        format.html { redirect_to(:action => "topicsList") }
	flash[:notice] = 'Topic was successfully created.'
        format.xml  { render :xml => @topic, :status => :created, :location => @topic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to(:action => "topicsList") }
	flash[:notice] = 'Topic was successfully updated.'
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic = Topic.find(params[:id])
	if @topic.user_id == current_user.id
		@topic.destroy
	end
    respond_to do |format|
      format.html { redirect_to(:action => "topicsList") }
      format.xml  { head :ok }
    end
  end
  
  def topicsList
    @thred = Thred.new
    @topic = Topic.new
    @topics = Topic.all
    @threads = @topic.threds
    session[:topic_id] = params[:id]	
  end
end
