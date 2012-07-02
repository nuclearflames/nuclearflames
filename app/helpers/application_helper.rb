module ApplicationHelper
	def GetUser(userid)
		if userid.nil?
			"No user defined"
		else
			User.find(userid)
		end
	end
end
