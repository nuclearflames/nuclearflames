class ThredsController < ApplicationController
skip_before_filter :authorizeUser, :only => ['show']
  # GET /threds
  # GET /threds.xml
  def index
    @threds = Thred.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @threds }
    end
  end

  # GET /threds/1
  # GET /threds/1.xml
  def show
    @post = Post.new
    @thred = Thred.find(params[:id])
    @posts = @thred.posts
    session[:threds_id] = params[:id]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @thred }
    end
  end

  # GET /threds/new
  # GET /threds/new.xml
  def new
    @thred = Thred.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @thred }
    end
  end

  # GET /threds/1/edit
  def edit
    @user = User.find(session[:id])
    @thred = Thred.find(params[:id])
    if @thred.owner_id != session[:id] || @user.status != "Administrator"
	redirect_to(thred_path(@thred.id))
	flash[:notice] = "Can't Edit what aint urs!! :O"
    end
  end

  # POST /threds
  # POST /threds.xml
  def create
    @thred = Thred.new(params[:thred])
    @thred.owner_id = session[:id]
    @thred.topic_id = session[:topic_id]
    
    respond_to do |format|
      if @thred.save
        format.html { redirect_to(topic_path(@thred.topic_id)) }
	flash[:notice] = 'Thread was successfully created.'
        format.xml  { render :xml => @thred, :status => :created, :location => @thred }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @thred.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /threds/1
  # PUT /threds/1.xml
  def update
    @thred = Thred.find(params[:id])

    respond_to do |format|
      if @thred.update_attributes(params[:thred])
        format.html { redirect_to(@thred, :notice => 'Thread was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @thred.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /threds/1
  # DELETE /threds/1.xml
  def destroy
    @thred = Thred.find(params[:id])
    @thred.destroy

    respond_to do |format|
      format.html { redirect_to(threds_url) }
      format.xml  { head :ok }
    end
  end
end
