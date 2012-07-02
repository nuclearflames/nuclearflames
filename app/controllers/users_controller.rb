class UsersController < ApplicationController
 skip_before_filter :authorizeUser, :only => ['new', 'create', 'show']
 #before_filter :authorizeAdmin, :only => ['index', 'edit']
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new	  
    if current_user
	@user1 = User.find(current_user)
    end
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end
  # GET /users/1/edit
  def edit
    @user1 = User.find(current_user)
    @user = User.find(params[:id])      
  end
  # GET /users/1/edit

  def show
	@user = User.find(params[:id])
	@user1 = User.find(params[:id])
	if current_user
		@user1 = User.find(current_user)
	end
	@location = @user.locations.all
	@timeline = @user.timelines.all
	
	    respond_to do |format|
	      format.html # index.html.erb
	      format.xml  { render :xml => @timeline }
	      format.xml  { render :xml => @location }
	    end
  end
  # POST /users
  # POST /users.xml
  def create
    if current_user
	@user1 = User.find(current_user)
    end
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
	if @user.status == "Inactive"
		session = UserSession.find
		session.destroy if session
		if @user.email == "nuclearflames@ymail.com" || @user.email == "jamesgrant1993@yahoo.com"
			UserMail.admin_registration_confirmation(@user).deliver
			flash[:notice] = '1st Administrator was successfully created, please check you email to activate the account.'
		else
			UserMail.registration_confirmation(@user).deliver
			flash[:notice] = 'User was successfully created please check your email to activate your account.'
		end
		format.html { redirect_to(:controller => 'home', :action => 'index' )}
		format.xml  { render :xml => @user, :status => :created, :location => @user }
	elsif @user.status == "Administrator"
		flash[:notice] = 'Administrator was successfully created.'
		format.html { redirect_to(:controller => 'home', :action => 'home' )}
		format.xml  { render :xml => @user, :status => :created, :location => @user }
	elsif @user.status == "User"
		flash[:notice] = 'User was successfully created.'
		format.html { redirect_to(:controller => 'home', :action => 'home' )}
		format.xml  { render :xml => @user, :status => :created, :location => @user }
	end
      else
	format.html { render :action => "new" }
	format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
	@user = User.find(params[:id])
	@user1 = User.find(current_user)
	@user.font = params[:font]
	@user.color = params[:color]
	@user.size = params[:size]
	
	if params[:edit] == "password"
		if request.post?
		user = User.authenticate(@user.email, params[:oldPassword])
			if user
			else
				redirect_to("home/edit?edit=password")
				flash.now[:notice] =  "Incorrect Password"
			end
		end
	end
    respond_to do |format|
      if @user.update_attributes(params[:user])
	UserMail.updateUser_notification(@user).deliver
	session[:edit] = nil
        format.html { redirect_to(:controller => 'home', :action => 'index')}
	flash[:notice] = 'User was successfully updated.'
        format.xml  { head :ok }
      else
        format.html { render(:controller => 'home', :action => 'edit') }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    if @user.id == current_user.id
	redirect_to(:controller => 'users', :action => 'index')
	flash[:notice] = 'Can\'t Delete Yourself!!.'
    else
	if current_user.status == "Administrator"
		@user.destroy
		#respond_to do |format|
		#	UserMail.destroyUser_notification(@user).deliver
		#end
		redirect_to root_url
		flash[:notice] = 'User Destroyed'
	end
    end
  end
  
  def found
	@users = User.search(params[:search])
  end
end
