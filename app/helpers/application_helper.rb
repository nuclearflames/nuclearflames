module ApplicationHelper
	def user
		if session[:id] != nil
			@user = User.find(session[:id]) 
		end
	end
end
