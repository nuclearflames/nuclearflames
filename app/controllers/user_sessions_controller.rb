class UserSessionsController < ApplicationController
	before_filter :authorizeUser, :only => :destroy
	
	def new
		@user_session = UserSession.new
	end
	
	def create
		if !current_user
			@user = User.find_by_email(params['user_session'].values)
			@user_session = UserSession.new(params[:user_session])
			if @user
				if @user.status == "Inactive"
					redirect_to root_url
					flash[:notice] = 'Activate your account to log in.'
				elsif @user.status != "Inactive" and @user_session.save
					flash.now[:notice] = 'Logged in.'
					redirect_to user_path(current_user)
				else
					flash.now[:notice] = 'Failed Log in.'
					render :action => :new	
				end
			else
				flash.now[:notice] = 'Failed Log in.'
				render :action => :new
			end
		else current_user
			@user_session = UserSession.new(params[:user_session])
			if @user_session.save
				session[:edit] = true;
				flash.now[:notice] = 'Activated edit attempt.'
				redirect_to edit_path				
			else
				flash.now[:notice] = 'Failed edit login attempt.'
				render :action => :new
			end
		end			
	end
	
	def destroy
		current_user_session.destroy
		redirect_to login_path
		flash[:notice] = 'Logged Out.'
	end
end
