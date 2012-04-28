class StoragesController < ApplicationController
  # GET /storages
  # GET /storages.xml
 skip_before_filter :authorizeAdmin, :only => ['edit']

  def index
    @storages = Storage.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @storages }
    end
  end

  # GET /storages/1
  # GET /storages/1.xml
  def show
    @storage = Storage.find(params[:id])
    
@user = User.find(session[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @storage }
    end
  end

  # GET /storages/new
  # GET /storages/new.xml
  def new
    @storage = Storage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @storage }
    end
  end

  # GET /storages/1/edit
  def edit
    @storage = Storage.find(params[:id])
	if session[:id] != @storage.user_id
		redirect_to(:action => "show")
		flash[:notice] = "Viewing this piece of data"
	end
  end

  # POST /storages
  # POST /storages.xml
  def create
    @storage = Storage.new(params[:storage])
    @storage.user_id = session[:id]
    @storaging = session[:id]
    
    respond_to do |format|
      if @storage.save
        format.html { redirect_to(:controller => 'home', :action => 'home') }
	flash[:notice] = 'Storage was successfully created.'
        format.xml  { render :xml => @storage, :status => :created, :location => @storage }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @storage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /storages/1
  # PUT /storages/1.xml
  def update
    @storage = Storage.find(params[:id])

    respond_to do |format|
      if @storage.update_attributes(params[:storage])
        format.html {redirect_to(:controller => 'home', :action => 'home')}
	flash[:notice] = 'Storage was successfully updated.'
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @storage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /storages/1
  # DELETE /storages/1.xml
  def destroy
    @storage = Storage.find(params[:id])
	if @storage.user_id == session[:id]
    @storage.destroy
end

    respond_to do |format|
      format.html { redirect_to(:controller => 'home', :action => 'storage') }
	flash[:notice] = 'Storage was successfully deleted.'
      format.xml  { head :ok }
    end
  end
end
