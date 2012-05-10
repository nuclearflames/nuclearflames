class LogonsController < ApplicationController
 skip_before_filter :authorizeUser, :only => ['logon', 'index']
  def logon
	if session[:id] != nil
		redirect_to(:controller => 'home', :action => 'index')	
		flash[:notice] = 'A login with a login, logception!'
	end
	
	if request.post?
		user = User.authenticate(params[:email], params[:password])
		if user
			if user.status == "Inactive"
				session[:registration_attempt] = user.id
				redirect_to(:controller => 'home', :action => 'index')
				flash[:notice] = 'Please activate your account to access this content.'
			else
				session[:registration_attempt] = nil
				session[:id] = user.id
				redirect_to(:controller => 'home', :action => 'home')
				flash[:notice] = 'Logged in'
			end
		else
			flash.now[:notice] = 'Invalid user/password combination'
		end
	end
  end

	def logonEdit
		@user = User.find(current_user)
		if session[:edit] == 'true'
			redirect_to(:controller => "home", :action => "edit")
		end
		
		if request.post?
		user = User.authenticate(params[:email], params[:password])
			if user
				if user.email == @user.email
					session[:edit] = 'true'
					redirect_to(:controller => "home", :action => "edit")
				end
			else
				flash.now[:notice] = 'Invalid password/Email'
			end
		end
	end
	
  def logoff
	if session[:id] != nil
		reset_session
		flash[:notice] = 'You are now logged off'
		redirect_to(:controller => 'home', :action => 'index')
	end
end
end
