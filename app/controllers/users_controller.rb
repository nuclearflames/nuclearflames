class UsersController < ApplicationController
 skip_before_filter :authorizeUser, :only => ['new', 'create']
 before_filter :authorizeAdmin, :only => ['index', 'edit']
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
    if session[:id] 
	    @user1 = User.find(session[:id])
    end
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end
  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end
  # GET /users/1/edit

  def show
	@user = User.find(params[:id])
  end
  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    @user.status = "Inactive" unless @user.status
    
    respond_to do |format|
      if @user.save
	if @user.status == "Inactive" 
		if @user.email == "nuclearflames@ymail.com"
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
		format.html { redirect_to(:controller => 'home', :action => 'index' )}
		format.xml  { render :xml => @user, :status => :created, :location => @user }
	elsif @user.status == "User"
		flash[:notice] = 'User was successfully created.'
		format.html { redirect_to(:controller => 'home', :action => 'index' )}
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
    @user.destroy

    respond_to do |format|
	UserMail.destroyUser_notification(@user).deliver
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
