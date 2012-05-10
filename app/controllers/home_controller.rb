class HomeController < ApplicationController
 skip_before_filter :authorizeUser, :only => ['index', 'resendEmail']
 skip_before_filter :authorizeAdmin, :only => ['index', 'resendEmail']
	  def index
		@users = User.all
		if current_user
			@user = User.find(current_user) 
		end
	  end
	  
	  def home
	  end
	  
	  def location
		if current_user
			@user = User.find(current_user)
			@location = @user.locations
		end
	  end
	  
	  def portfolio
		@user = User.find(current_user)
		@timeline = @user.timelines.sort_by(&:date).reverse
		@storage = @user.storages	  
	  end
  
	def edit	  
		if current_user
		    @user1 = User.find(current_user)
		end
		@user = User.find(current_user)
		unless session[:edit] == true
			redirect_to(login_path)
			flash[:notice] = "Please input you password again to update your account"
		end
	end
  
	def storage
		@user = User.find(current_user)
		@storage = @user.storages	  
	end
  
	def upload
		file = params[:form][:file]
		@file_type = file.content_type
		@file_name = file.original_filename
		@file_contents = file.read
		File.open('c:/temp/' + @file_name, 'w') do |f|
			f.write(@file_contents)
		end
	end  
  
	def resendEmail
		if session[:registration_attempt] != nil
		@user = User.find(session[:registration_attempt])
			if @user.status == 'Inactive'
				UserMail.registration_confirmation(@user).deliver
				redirect_to(:controller => 'home', :action => 'index')
				flash[:notice] = 'Email Sent.'
				session[:registration_attempt] = nil
			end
		end
	end

	def editFile
		@user = User.find(current_user)
		@storage = Storage.find(params[:id])
	end

	def timeline
		@user = User.find(current_user)
		@timeline = @user.timelines.sort_by(&:date).reverse
	end
end
