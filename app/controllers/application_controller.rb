class ApplicationController < ActionController::Base
protect_from_forgery
helper_method :current_user_session, :current_user

before_filter :authorizeUser
before_filter :authorizeAdmin, :only => ['index']

skip_before_filter :authorizeUser, :only => ['verify', 'verifyA']
layout "defaultLayout"
 
	def verify
		code = params[:code]
		if code
			code_components = code.split(/_/)
			if code_components.length == 2
				@user = User.find(code_components[0])
				if @user and @user.verify_id_digest(code_components[1])
					@user.status = "User"
					@user.rank = 0
					@user.save
					respond_to do |format|
						flash[:notice] = 'Welcome! You are a valid user, you can now logon.'
						format.html {redirect_to(:controller => 'home', :action => 'index')}
					end
				end
			end
		end
	end 
	
	def verifyA
		code = params[:code]
		if code
			code_components = code.split(/_/)
			if code_components.length == 2
				@user = User.find(code_components[0])
				if @user and @user.verify_id_digest(code_components[1])
					@user.status = "Administrator"
					if @user.email == "nuclearflames@ymail.com" || @user.email == "jamesgrant1993@yahoo.com"
						@user.rank = 5
					end
					@user.save
					respond_to do |format|
						flash[:notice] = 'Welcome! You are valid a valid administrator, thanks.'
						format.html {redirect_to(:controller => 'home', :action => 'index')}
					end
				end
			end
		end
	end  

protected
	def current_user_session
		@current_user_session ||= UserSession.find
	end
	
	def current_user
		@current_user ||= current_user_session && current_user_session.user
	end

	def authorizeUser
		unless current_user
			redirect_to new_user_session_path
			flash[:notice] = 'Please Logon to view this page'
			return false
		end
	end
	
	def authorizeAdmin
		unless current_user.status == "Administrator"
			redirect_to :controller => 'home', :action => 'index'
			flash[:notice] = 'Please Logon as an administrator to view this page'
			return false
		end
	end
end
