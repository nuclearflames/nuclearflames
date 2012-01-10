class HomeController < ApplicationController
 skip_before_filter :authorizeUser, :only => ['index']
 skip_before_filter :authorizeAdmin, :only => ['index']
  def index
  end
  
  def home
  end
  
  def edit
    @user = User.find(session[:id])
	unless session[:edit] == 'true'
		redirect_to(:controller => 'logons', :action => 'logonEdit')
		flash[:notice] = "Please input you password again to update your account"
	end
  end
  
  def storage
	@user = User.find(session[:id])
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
	@user = User.find(session[:id])
	@storage = Storage.find(params[:id])
  end
end
